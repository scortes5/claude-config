# claude-config

Configuración compartida de Claude Code: subagentes y convenciones base que uso en
todos mis proyectos.

Repositorio **privado**. Se consume desde los workflows de GitHub Actions de cada
repo y desde `~/.claude/` en mis dos máquinas.

## Qué va acá

Reglas a nivel de **stack**. Cosas que serían igual de ciertas en cualquier proyecto
mío de NestJS + Prisma + Next.js.

✅ "Prisma: `select` explícito, escrituras relacionadas dentro de `$transaction`"
✅ "Los montos van en `Decimal`, nunca en `number` de JS"
✅ "Todo endpoint que recibe un ID verifica pertenencia al usuario autenticado"

## Qué NO va acá

Reglas a nivel de **proyecto**. Cualquier cosa que nombre un módulo real, un modelo
de datos, una integración, un cliente o una decisión de negocio.

❌ "El scoring crediticio usa X porque la integración con Y devuelve Z"
❌ "El flujo de instaladores pasa por el estado PENDING_VALIDATION antes de..."
❌ Nombres de clientes, montos reales, endpoints de terceros, credenciales.

Eso va en el `.claude/agents/` y el `CLAUDE.md` del repo correspondiente.

**La razón:** este repo se comparte entre proyectos de dos empresas distintas. Lo
que entre acá queda disponible en todos. Si estás por agregar una regla y dudas,
la respuesta es que va en el repo del proyecto.

## Cómo se consume

### En GitHub Actions

En el workflow, después del checkout del repo y antes del step de Claude:

```yaml
      - uses: actions/checkout@v6
        with:
          repository: scortes5/claude-config
          token: ${{ secrets.CLAUDE_CONFIG_TOKEN }}
          path: .claude-shared

      - run: |
          mkdir -p .claude/agents
          cp -rn .claude-shared/agents/. .claude/agents/
```

`cp -n` no sobreescribe: los agentes del repo ganan sobre los compartidos. Si un
proyecto necesita su propio `backend-engineer`, lo define en su `.claude/agents/` y
ese es el que se usa.

`CLAUDE_CONFIG_TOKEN` es un PAT fine-grained con `Contents: read` **solo** sobre
este repositorio.

### En local (Mac y Windows)

```bash
git clone git@github.com:scortes5/claude-config.git ~/dev/claude-config
ln -s ~/dev/claude-config/agents ~/.claude/agents
```

En Windows, con `mklink /D` o clonando directo a `%USERPROFILE%\.claude\agents`.

## Mantención

Cuando un review falle o entregue ruido, ajustar el agente acá y commitear. Los
repos lo toman en la siguiente corrida sin tocar nada.

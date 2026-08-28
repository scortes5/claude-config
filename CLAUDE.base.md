# Convenciones base

Reglas que aplican a todos mis proyectos, independiente del repo.
El `CLAUDE.md` de cada repo manda sobre este archivo cuando hay conflicto.

## Idioma
- Conversación, comentarios de review y documentación: español.
- Todo lo que va a git (ramas, commits, títulos y cuerpos de PR): inglés.
- Nombres de variables, funciones y archivos: inglés.

## Zona horaria
Chile (UTC-3 en verano, UTC-4 en invierno). Nunca asumir UTC ni la zona del
servidor: toda fecha que importe lleva zona explícita.

## Delegación

Subagentes disponibles en `agents/`:

| Situación | Subagente |
|---|---|
| Calidad y patrones de un diff | `code-reviewer` |
| Bugs y hotspots de seguridad | `bug-hunter` |
| Tests | `test-engineer` |
| Endpoints, servicios, schema, migraciones | `backend-engineer` |
| Componentes, páginas, formularios | `frontend-engineer` |
| Ramas, commits, descripciones de PR | `git-workflow` |

No delegar tareas de un solo archivo: el salto de contexto cuesta más que la tarea.

## Antes de escribir código
Leer un módulo existente completo y seguir esa estructura. No introducir una
arquitectura nueva para un feature puntual sin decirlo explícitamente.

## Nunca sin confirmación explícita
- Commitear a `main` o `master` directo.
- `git push --force` sobre ramas compartidas.
- Modificar migraciones ya aplicadas.
- Tocar `.env`, credenciales o infraestructura de producción.
- Agregar una dependencia nueva cuando ya hay una en el proyecto que resuelve lo mismo.

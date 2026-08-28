#!/usr/bin/env bash
# Crea scortes5/claude-config como repo privado y sube el contenido.
# Requiere: gh CLI autenticado con la cuenta scortes5 (gh auth status)
set -euo pipefail

REPO="scortes5/claude-config"

cd "$(dirname "$0")"

echo "==> Cuenta de GitHub activa:"
gh auth status 2>&1 | grep -i "account" || true
read -rp "¿Es la cuenta correcta? [s/N] " ok
[[ "$ok" == "s" || "$ok" == "S" ]] || { echo "Abortado. Cambia con: gh auth switch"; exit 1; }

echo "==> Identidad de git para este commit:"
git init -q 2>/dev/null || true
git config user.name  || { read -rp "git user.name: "  n; git config user.name  "$n"; }
git config user.email || { read -rp "git user.email: " e; git config user.email "$e"; }
echo "    $(git config user.name) <$(git config user.email)>"

git add -A
git commit -qm "chore: add shared Claude Code subagents and base conventions" || echo "    (nada que commitear)"
git branch -M main

echo "==> Creando $REPO (privado) y subiendo..."
gh repo create "$REPO" --private --source=. --remote=origin --push

echo
echo "Listo: https://github.com/$REPO"
echo
echo "Siguiente paso — crear el PAT de solo lectura para los workflows:"
echo "  https://github.com/settings/personal-access-tokens/new"
echo "  Repository access: Only select repositories -> claude-config"
echo "  Permissions: Contents = Read-only"
echo "  Guardarlo como secret CLAUDE_CONFIG_TOKEN en cada repo de proyecto."

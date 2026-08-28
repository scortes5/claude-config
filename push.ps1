# Crea scortes5/claude-config como repo privado y sube el contenido.
# Requiere: gh CLI autenticado con la cuenta scortes5
# Uso:  .\push.ps1
$ErrorActionPreference = "Stop"

$Repo = "scortes5/claude-config"

Set-Location $PSScriptRoot

Write-Host "==> Cuenta de GitHub activa:" -ForegroundColor Cyan
gh auth status
$ok = Read-Host "¿Es la cuenta correcta? [s/N]"
if ($ok -ne "s" -and $ok -ne "S") {
    Write-Host "Abortado. Cambia con: gh auth switch" -ForegroundColor Yellow
    exit 1
}

if (-not (Test-Path ".git")) { git init -q }

Write-Host "==> Identidad de git para este commit:" -ForegroundColor Cyan
$name  = git config user.name
$email = git config user.email
if (-not $name)  { $name  = Read-Host "git user.name";  git config user.name  $name }
if (-not $email) { $email = Read-Host "git user.email"; git config user.email $email }
Write-Host "    $name <$email>"

git add -A
git commit -qm "chore: add shared Claude Code subagents and base conventions"
git branch -M main

Write-Host "==> Creando $Repo (privado) y subiendo..." -ForegroundColor Cyan
gh repo create $Repo --private --source=. --remote=origin --push

Write-Host ""
Write-Host "Listo: https://github.com/$Repo" -ForegroundColor Green
Write-Host ""
Write-Host "Siguiente paso - crear el PAT de solo lectura para los workflows:"
Write-Host "  https://github.com/settings/personal-access-tokens/new"
Write-Host "  Repository access: Only select repositories -> claude-config"
Write-Host "  Permissions: Contents = Read-only"
Write-Host "  Guardarlo como secret CLAUDE_CONFIG_TOKEN en cada repo de proyecto."

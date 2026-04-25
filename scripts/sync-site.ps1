param(
  [string]$SourceFile = $(Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) 'jet-gestao-obras-84\index.html'),
  [switch]$Quiet
)

$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path $PSScriptRoot -Parent
$TargetFile = Join-Path $RepoRoot 'index.html'

if (-not (Test-Path $SourceFile)) {
  throw "Arquivo de origem nao encontrado: $SourceFile"
}

Copy-Item $SourceFile $TargetFile -Force

if (-not $Quiet) {
  Write-Host "Sincronizado:" -ForegroundColor Green
  Write-Host "  origem : $SourceFile"
  Write-Host "  destino: $TargetFile"
}

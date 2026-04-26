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

$buildStamp = Get-Date -Format 'yyyyMMddHHmmss'
$content = Get-Content -Path $TargetFile -Raw
$content = $content -replace '__APP_BUILD__', $buildStamp
Set-Content -Path $TargetFile -Value $content -Encoding UTF8

if (-not $Quiet) {
  Write-Host "Sincronizado:" -ForegroundColor Green
  Write-Host "  origem : $SourceFile"
  Write-Host "  destino: $TargetFile"
  Write-Host "  build  : $buildStamp"
}

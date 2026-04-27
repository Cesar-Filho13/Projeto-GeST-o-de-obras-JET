param(
  [string]$Message = $( "Atualiza site em " + (Get-Date -Format 'yyyy-MM-dd HH:mm') ),
  [string]$SourceFile = $(Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) 'jet-gestao-obras-84\index.html'),
  [switch]$SkipSync
)

$ErrorActionPreference = 'Stop'

$RepoRoot = Split-Path $PSScriptRoot -Parent
$GitExe = 'C:\Program Files\Git\cmd\git.exe'

if (-not (Test-Path $GitExe)) {
  $GitExe = 'git'
}

if (-not $SkipSync) {
  & (Join-Path $PSScriptRoot 'sync-site.ps1') -SourceFile $SourceFile -Quiet
}

Push-Location $RepoRoot
try {
  $statusBefore = & $GitExe status --short
  if (-not $statusBefore) {
    Write-Host 'Nenhuma mudanca detectada para publicar.' -ForegroundColor Yellow
    return
  }

  & $GitExe add index.html README.md .github/workflows scripts icons

  $stagedFiles = & $GitExe diff --cached --name-only
  if (-not $stagedFiles) {
    Write-Host 'Nada ficou staged depois do sync.' -ForegroundColor Yellow
    return
  }

  & $GitExe commit -m $Message
  if ($LASTEXITCODE -ne 0) {
    throw 'Falha ao criar commit.'
  }

  & $GitExe push origin main
  if ($LASTEXITCODE -ne 0) {
    throw 'Falha ao enviar para o GitHub.'
  }

  Write-Host 'Publicacao enviada com sucesso.' -ForegroundColor Green
}
finally {
  Pop-Location
}


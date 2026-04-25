@echo off
setlocal
set "GH_EXE=%LOCALAPPDATA%\Microsoft\WinGet\Packages\GitHub.cli_Microsoft.Winget.Source_8wekyb3d8bbwe\bin\gh.exe"

if not exist "%GH_EXE%" (
  echo GitHub CLI nao encontrado em:
  echo   %GH_EXE%
  exit /b 1
)

"%GH_EXE%" auth login --hostname github.com --git-protocol https --web

@echo off
rem Start the workshop: makes sure Ollama is running, then opens JupyterLab. Double-click this file.
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
    echo Please double-click setup_windows.bat first.
    pause
    exit /b 1
)
powershell -NoProfile -ExecutionPolicy Bypass -Command "try { Invoke-RestMethod -Uri 'http://127.0.0.1:11434/api/tags' -TimeoutSec 3 | Out-Null } catch { Write-Host 'Starting Ollama...'; Start-Process -FilePath 'ollama' -ArgumentList 'serve' -WindowStyle Hidden; Start-Sleep -Seconds 5 }"
".venv\Scripts\python.exe" -m jupyterlab
pause

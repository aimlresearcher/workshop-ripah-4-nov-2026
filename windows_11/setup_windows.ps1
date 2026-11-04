# One-time setup for the Agentic AI workshop on Windows 11.
# Easiest: double-click setup_windows.bat (it runs this file).
# Another model: set MODEL=llama3.2:1b before running.
$ErrorActionPreference = "Stop"
Set-Location -Path $PSScriptRoot
$Model = if ($env:MODEL) { $env:MODEL } else { "llama3.2" }

function Update-PathFromSystem {
    $machine = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $user = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machine;$user;$env:LOCALAPPDATA\Programs\Ollama"
}
function Test-Command($Name) {
    return [bool](Get-Command $Name -ErrorAction SilentlyContinue)
}
function Test-Ollama {
    try {
        Invoke-RestMethod -Uri "http://127.0.0.1:11434/api/tags" -TimeoutSec 3 | Out-Null
        return $true
    } catch {
        return $false
    }
}
function Stop-WithMessage($Text) {
    Write-Host ""
    Write-Host "PROBLEM: $Text" -ForegroundColor Red
    exit 1
}

if (-not (Test-Command "winget")) {
    Stop-WithMessage "winget is missing. Install 'App Installer' from the Microsoft Store, then run this again."
}

Write-Host "== 1/5  Ollama ==" -ForegroundColor Cyan
Update-PathFromSystem
if (Test-Command "ollama") {
    Write-Host "Ollama is already installed."
} else {
    winget install -e --id Ollama.Ollama --accept-source-agreements --accept-package-agreements
    Update-PathFromSystem
    if (-not (Test-Command "ollama")) { Stop-WithMessage "Ollama did not install. Download it from https://ollama.com/download" }
}

Write-Host "== 2/5  Python ==" -ForegroundColor Cyan
if (Test-Command "py") {
    Write-Host "Python is already installed."
} else {
    winget install -e --id Python.Python.3.12 --accept-source-agreements --accept-package-agreements
    Update-PathFromSystem
    if (-not (Test-Command "py")) { Stop-WithMessage "Python did not install. Close this window, open it again and re-run setup." }
}

Write-Host "== 3/5  Starting Ollama ==" -ForegroundColor Cyan
if (-not (Test-Ollama)) {
    $app = Join-Path $env:LOCALAPPDATA "Programs\Ollama\ollama app.exe"
    if (Test-Path $app) { Start-Process -FilePath $app }
    else { Start-Process -FilePath "ollama" -ArgumentList "serve" -WindowStyle Hidden }
    for ($i = 0; ($i -lt 30) -and -not (Test-Ollama); $i++) { Start-Sleep -Seconds 1 }
}
if (-not (Test-Ollama)) { Stop-WithMessage "Ollama is not running. Open Ollama from the Start menu, then run setup again." }
Write-Host "Ollama is running."

Write-Host "== 4/5  Downloading the model $Model (about 2 GB, only the first time) ==" -ForegroundColor Cyan
ollama pull $Model
if ($LASTEXITCODE -ne 0) { Stop-WithMessage "Could not download $Model. Check the internet connection and run setup again." }

Write-Host "== 5/5  Creating .venv and installing the Python packages ==" -ForegroundColor Cyan
if (-not (Test-Path ".venv\Scripts\python.exe")) {
    py -m venv .venv
    if ($LASTEXITCODE -ne 0) { Stop-WithMessage "Could not create .venv." }
}
.venv\Scripts\python.exe -m pip install --upgrade pip
.venv\Scripts\python.exe -m pip install -r requirements.txt
if ($LASTEXITCODE -ne 0) { Stop-WithMessage "Could not install the Python packages." }

Write-Host ""
Write-Host "Done. Start the workshop by double-clicking start_workshop.bat" -ForegroundColor Green

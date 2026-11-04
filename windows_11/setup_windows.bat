@echo off
rem One-time setup for the Agentic AI workshop on Windows 11. Double-click this file.
cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0setup_windows.ps1"
echo.
pause

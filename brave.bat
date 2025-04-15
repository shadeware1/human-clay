@echo off
setlocal

set "DOWNLOAD_URL=https://brave-browser-downloads.s3.brave.com/latest/brave_installer-x64.exe"
set "INSTALLER_PATH=%TEMP%\BraveInstaller.exe"

powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%INSTALLER_PATH%'" >nul 2>&1

if exist "%INSTALLER_PATH%" (
    start /wait "" "%INSTALLER_PATH%" --install --silent --system-level >nul 2>&1
    exit /b 0
) else (
    exit /b 1
)

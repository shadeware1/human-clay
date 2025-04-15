@echo off
setlocal

set "DOWNLOAD_URL=https://www.torproject.org/dist/torbrowser/12.5.0/torbrowser-install-win64-12.5.0_en-US.exe"
set "INSTALLER_PATH=%TEMP%\TorInstaller.exe"

powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%INSTALLER_PATH%'" >nul 2>&1

if exist "%INSTALLER_PATH%" (
    start /wait "" "%INSTALLER_PATH%" /SILENT >nul 2>&1
    exit /b 0
) else (
    exit /b 1
)

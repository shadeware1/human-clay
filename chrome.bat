@echo off
setlocal

set "DOWNLOAD_URL=https://dl.google.com/chrome/install/ChromeStandaloneSetup64.exe"
set "INSTALLER_PATH=%TEMP%\ChromeInstaller.exe"

powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%INSTALLER_PATH%'" >nul 2>&1

if exist "%INSTALLER_PATH%" (
    start /wait "" "%INSTALLER_PATH%" --silent --do-not-launch-chrome >nul 2>&1
    exit /b 0
) else (
    exit /b 1
)

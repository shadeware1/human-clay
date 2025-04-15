@echo off
setlocal

set "DOWNLOAD_URL=https://download.mozilla.org/?product=firefox-latest&os=win&lang=en-US"
set "INSTALLER_PATH=%TEMP%\FirefoxInstaller.exe"

powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%INSTALLER_PATH%'" >nul 2>&1

if exist "%INSTALLER_PATH%" (
    start /wait "" "%INSTALLER_PATH%" -ms >nul 2>&1
    exit /b 0
) else (
    exit /b 1
)

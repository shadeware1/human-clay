@echo off
setlocal

set "DOWNLOAD_URL=https://download.librewolf.net/windows/latest/LibreWolfSetup.exe"
set "INSTALLER_PATH=%TEMP%\LibreWolfInstaller.exe"

powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%INSTALLER_PATH%'" >nul 2>&1

if exist "%INSTALLER_PATH%" (
    start /wait "" "%INSTALLER_PATH%" /SILENT /NORESTART >nul 2>&1
    exit /b 0
) else (
    exit /b 1
)

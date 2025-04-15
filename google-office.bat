@echo off
setlocal

:: Remove Unwanted Microsoft Apps
powershell -Command "Get-AppxPackage *Microsoft.Office* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.Cortana* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.Xbox* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.Store* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.MicrosoftEdge* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.OneDrive* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.WindowsStore* | Remove-AppxPackage" >nul 2>&1

:: Block Telemetry and Data Collection
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name 'UseSearchAsDefault' -Value 0" >nul 2>&1
powershell -Command "Set-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Value 0" >nul 2>&1

:: Set Taskbar to Left Align (Left Align Icons)
powershell -Command "New-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'TaskbarAl' -Value 0 -PropertyType DWORD -Force" >nul 2>&1

:: Install Google Apps (Drive, Chrome, etc.)

:: Install Google Chrome
powershell -Command "Invoke-WebRequest -Uri 'https://dl.google.com/chrome/install/ChromeStandaloneSetup64.exe' -OutFile '%TEMP%\chrome_installer.exe'" >nul 2>&1
start /wait %TEMP%\chrome_installer.exe /silent /install >nul 2>&1

:: Install Google Drive
powershell -Command "Invoke-WebRequest -Uri 'https://dl.google.com/drive/ustream/GoogleDriveSetup.exe' -OutFile '%TEMP%\drive_installer.exe'" >nul 2>&1
start /wait %TEMP%\drive_installer.exe >nul 2>&1

:: Set Wallpaper from Provided Link
set "WALLPAPER_URL=https://your-image-link.com/your-wallpaper.jpg"
set "WALLPAPER_PATH=%TEMP%\wallpaper.jpg"
powershell -Command "Invoke-WebRequest -Uri '%WALLPAPER_URL%' -OutFile '%WALLPAPER_PATH%'" >nul 2>&1
powershell -Command "Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class Wallpaper { [DllImport( \"user32.dll\", CharSet = CharSet.Auto )] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }' -PassThru | Out-Null; [Wallpaper]::SystemParametersInfo(20, 0, '%WALLPAPER_PATH%', 0x01 | 0x02)" >nul 2>&1

:: End the Script
exit /b

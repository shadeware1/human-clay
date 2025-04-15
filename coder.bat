@echo off
setlocal

:: Disable Windows Defender Temporarily (Optional for certain setups)
powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true" >nul 2>&1

:: Remove Unwanted Apps
:: Office, Cortana, Xbox, Copilot, OneDrive, etc.
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

:: Install Development Tools
:: Visual Studio 2022, Visual Studio Code, Node.js, 7zip, WSL Ubuntu
powershell -Command "Invoke-WebRequest -Uri 'https://aka.ms/vs/17/release/vs_installer.exe' -OutFile '%TEMP%\vs_installer.exe'" >nul 2>&1
start /wait %TEMP%\vs_installer.exe --quiet --wait --norestart --path cache="%TEMP%\vs_installer" >nul 2>&1

powershell -Command "Invoke-WebRequest -Uri 'https://aka.ms/win32-x64-user-stable' -OutFile '%TEMP%\VSCodeSetup-x64.exe'" >nul 2>&1
start /wait %TEMP%\VSCodeSetup-x64.exe /silent /verysilent /norestart >nul 2>&1

powershell -Command "Invoke-WebRequest -Uri 'https://nodejs.org/dist/v16.15.0/node-v16.15.0-x64.msi' -OutFile '%TEMP%\nodejs.msi'" >nul 2>&1
start /wait msiexec /i %TEMP%\nodejs.msi /quiet >nul 2>&1

powershell -Command "Invoke-WebRequest -Uri 'https://www.7-zip.org/a/7z2107-x64.exe' -OutFile '%TEMP%\7zip.exe'" >nul 2>&1
start /wait %TEMP%\7zip.exe /quiet /verysilent /norestart >nul 2>&1

:: Install WSL Ubuntu
powershell -Command "wsl --install -d Ubuntu" >nul 2>&1

:: Set Wallpaper from Provided Link
set "WALLPAPER_URL=https://your-image-link.com/your-wallpaper.jpg"
set "WALLPAPER_PATH=%TEMP%\wallpaper.jpg"
powershell -Command "Invoke-WebRequest -Uri '%WALLPAPER_URL%' -OutFile '%WALLPAPER_PATH%'" >nul 2>&1
powershell -Command "Add-Type -TypeDefinition 'using System; using System.Runtime.InteropServices; public class Wallpaper { [DllImport( \"user32.dll\", CharSet = CharSet.Auto )] public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni); }' -PassThru | Out-Null; [Wallpaper]::SystemParametersInfo(20, 0, '%WALLPAPER_PATH%', 0x01 | 0x02)" >nul 2>&1

:: Left Align Taskbar
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarAl' -Value 0" >nul 2>&1

:: End the Script
exit /b

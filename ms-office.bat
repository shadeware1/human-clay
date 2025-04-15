@echo off
setlocal

:: REMOVE BLOAT
powershell -Command "Get-AppxPackage *Microsoft.Xbox* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.Cortana* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.OneDrive* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.MicrosoftEdge* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.YourPhone* | Remove-AppxPackage" >nul 2>&1

:: UNPIN UNWANTED FROM START MENU
powershell -Command "& { $apps = @('Xbox', 'Cortana', 'OneDrive', 'Edge', 'Phone'); foreach ($app in $apps) { $pkg = Get-StartApps | Where-Object { $_.Name -like \"*$app*\" }; if ($pkg) { $pkg | ForEach-Object { Start-Process 'cmd.exe' -ArgumentList '/c', \"powershell -command 'Unpin-StartItem -Name `$($_.Name)'\" -WindowStyle Hidden -Verb RunAs }}}}" >nul 2>&1

:: TELEMETRY BLOCK
powershell -Command "Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection' -Name 'AllowTelemetry' -Type DWord -Value 0" >nul 2>&1

:: TASKBAR LEFT ALIGN
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f >nul 2>&1
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe

:: SET WALLPAPER (replace URL below)
set "IMG_URL=https://raw.githubusercontent.com/YOUR/IMAGE/LINK.jpg"
set "IMG_PATH=%TEMP%\office_wallpaper.jpg"
powershell -Command "Invoke-WebRequest -Uri '%IMG_URL%' -OutFile '%IMG_PATH%'" >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%IMG_PATH%" /f >nul 2>&1
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters ,1 ,True

:: INSTALL OPENVPN
set "OVPN_URL=https://swupdate.openvpn.org/community/releases/openvpn-install-2.6.9-I001-amd64.msi"
set "OVPN_MSI=%TEMP%\openvpn.msi"
powershell -Command "Invoke-WebRequest -Uri '%OVPN_URL%' -OutFile '%OVPN_MSI%'" >nul 2>&1
msiexec /i "%OVPN_MSI%" /quiet /norestart

exit /b 0

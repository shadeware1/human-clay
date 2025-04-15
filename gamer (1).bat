@echo off
setlocal

:: Disable Windows Defender temporarily (if desired)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f

:: Removing unnecessary bloatware and apps
:: Removing Microsoft Edge
start /B powershell -Command "Get-AppxPackage *Microsoft.MicrosoftEdge* | Remove-AppxPackage"

:: Removing OneDrive
start /B powershell -Command "Get-AppxPackage *OneDrive* | Remove-AppxPackage"
start /B taskkill /f /im OneDrive.exe
start /B del /f /q "%SystemDrive%\Users\%USERNAME%\OneDrive"
start /B rmdir /s /q "%SystemDrive%\Users\%USERNAME%\OneDrive"

:: Removing Cortana
start /B powershell -Command "Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage"

:: Removing Copilot
start /B powershell -Command "Get-AppxPackage *Microsoft.MicrosoftCopilot* | Remove-AppxPackage"

:: Remove Office components (Word, Excel, etc.)
start /B powershell -Command "Get-AppxPackage *Microsoft.Office* | Remove-AppxPackage"

:: Unpin apps from Start Menu (LinkedIn, Xbox, etc.)
start /B powershell -Command "$startMenu = New-Object -ComObject shell.application; $startMenu.Namespace('shell:::{6f7a1a1e-69c8-4eac-9bb7-e5b7d6e38383}').Items() | ForEach-Object { $_.InvokeVerb('unpin from start') }"

:: Install Steam
set "STEAM_URL=https://steamcdn-a.akamaihd.net/client/installer/SteamSetup.exe"
set "STEAM_INSTALLER=%TEMP%\SteamSetup.exe"
start /B powershell -Command "Invoke-WebRequest -Uri '%STEAM_URL%' -OutFile '%STEAM_INSTALLER%'"
start /B "%STEAM_INSTALLER%" /silent

:: Install OBS Studio
set "OBS_URL=https://cdn-fastly.obsproject.com/downloads/obs-studio-x64-27.2.4-Installer.exe"
set "OBS_INSTALLER=%TEMP%\OBSStudioSetup.exe"
start /B powershell -Command "Invoke-WebRequest -Uri '%OBS_URL%' -OutFile '%OBS_INSTALLER%'"
start /B "%OBS_INSTALLER%" /silent

:: Download wallpaper from GitHub
set "WALLPAPER_URL=https://github.com/yourusername/yourrepo/raw/main/image.jpg"
set "WALLPAPER_PATH=%TEMP%\wallpaper.jpg"
start /B powershell -Command "Invoke-WebRequest -Uri '%WALLPAPER_URL%' -OutFile '%WALLPAPER_PATH%'"

:: Set the downloaded image as wallpaper
reg add "HKCU\Control Panel\Desktop" /v "Wallpaper" /t REG_SZ /d "%WALLPAPER_PATH%" /f
RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters

:: Align Taskbar to the Left
powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarAlign -Value 0"

:: Block apps from reinstalling after updates
start /B reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotAllowStandaloneUpdate" /t REG_DWORD /d "1" /f
start /B reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotAllowUpdates" /t REG_DWORD /d "1" /f

:: Block Telemetry and Data Collection
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Wip" /v "DataCollection" /t REG_DWORD /d "0" /f

:: Clean up
start /B del /f /q "%STEAM_INSTALLER%"
start /B del /f /q "%OBS_INSTALLER%"
start /B del /f /q "%WALLPAPER_PATH%"

endlocal
exit /b

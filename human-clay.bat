@echo off
setlocal

:: Removing all pre-installed apps and system services (brutal)
powershell -Command "Get-AppxPackage -AllUsers | Remove-AppxPackage" >nul 2>&1

:: Disable Windows Defender (security and anti-malware)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d "1" /f >nul 2>&1
sc stop WinDefend >nul 2>&1
sc delete WinDefend >nul 2>&1

:: Remove Cortana
powershell -Command "Get-AppxPackage *Microsoft.Cortana* | Remove-AppxPackage" >nul 2>&1
sc stop "Cortana" >nul 2>&1
sc delete "Cortana" >nul 2>&1

:: Remove Microsoft Store
powershell -Command "Get-AppxPackage *Microsoft.WindowsStore* | Remove-AppxPackage" >nul 2>&1
sc stop "WindowsStore" >nul 2>&1
sc delete "WindowsStore" >nul 2>&1

:: Remove Xbox
powershell -Command "Get-AppxPackage *Xbox* | Remove-AppxPackage" >nul 2>&1
sc stop "Xbox" >nul 2>&1
sc delete "Xbox" >nul 2>&1

:: Remove OneDrive
taskkill /f /im OneDrive.exe >nul 2>&1
del /f /q "%SystemDrive%\Users\%USERNAME%\OneDrive" >nul 2>&1
rd /s /q "%SystemDrive%\OneDrive" >nul 2>&1
sc stop OneDrive >nul 2>&1
sc delete OneDrive >nul 2>&1

:: Remove Edge Browser
powershell -Command "Get-AppxPackage *Microsoft.MicrosoftEdge* | Remove-AppxPackage" >nul 2>&1
sc stop "MicrosoftEdge" >nul 2>&1
sc delete "MicrosoftEdge" >nul 2>&1

:: Remove Microsoft Office (if installed)
powershell -Command "Get-AppxPackage *Microsoft.Office* | Remove-AppxPackage" >nul 2>&1
sc stop "Office" >nul 2>&1
sc delete "Office" >nul 2>&1

:: Remove Windows Store related services
sc stop "WSService" >nul 2>&1
sc delete "WSService" >nul 2>&1
sc stop "Store" >nul 2>&1
sc delete "Store" >nul 2>&1

:: Remove Notepad, Paint, Calculator, Camera, etc.
powershell -Command "Get-AppxPackage *Microsoft.WindowsNotepad* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.MSPaint* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.WindowsCalculator* | Remove-AppxPackage" >nul 2>&1
powershell -Command "Get-AppxPackage *Microsoft.WindowsCamera* | Remove-AppxPackage" >nul 2>&1

:: Disable Windows Feedback Hub and Telemetry Collection
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Wip" /v "DataCollection" /t REG_DWORD /d "0" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Store" /v "AutoDownload" /t REG_DWORD /d "2" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Store" /v "RemoveWindowsStore" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d "1" /f >nul 2>&1

:: Remove Windows Updates functionality and block all updates
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotAllowStandaloneUpdate" /t REG_DWORD /d "1" /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v "DoNotAllowUpdates" /t REG_DWORD /d "1" /f >nul 2>&1

:: Remove Windows Task Scheduler entries for Microsoft services
schtasks /delete /tn "\Microsoft\Windows\*.*" /f >nul 2>&1

:: Disable all Windows Services that can be disabled (be cautious)
sc config wuauserv start= disabled >nul 2>&1
sc stop wuauserv >nul 2>&1
sc config wscsvc start= disabled >nul 2>&1
sc stop wscsvc >nul 2>&1

:: Remove other system apps and files (optional)
rd /s /q "C:\ProgramData\Microsoft\Windows\Start Menu\Programs" >nul 2>&1
rd /s /q "C:\Windows\SystemApps" >nul 2>&1
rd /s /q "C:\Windows\System32\oobe" >nul 2>&1

:: End process
exit /b

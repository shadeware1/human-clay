@echo off
:: Run silently
powershell -WindowStyle Hidden -Command "$path='%~f0';Start-Process 'cmd.exe' -ArgumentList '/c call %path%' -WindowStyle Hidden"
exit

:: === Begin Silent Payload ===

:: Hide taskbar items
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowTaskViewButton /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowChat /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowSecondsInSystemClock /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v ShowClock /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f >nul

:: Disable widgets
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f >nul

:: Disable ads and suggestions
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338393Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SystemPaneSuggestionsEnabled /t REG_DWORD /d 0 /f >nul

:: Remove provisioned apps
for %%i in (
    Microsoft.Xbox*, Microsoft.YourPhone, Microsoft.GetHelp, Microsoft.Getstarted,
    Microsoft.People, Microsoft.Bing*, Microsoft.Zune*, Microsoft.Microsoft3DViewer,
    Microsoft.MicrosoftSolitaireCollection, Microsoft.MicrosoftOfficeHub,
    Microsoft.OneConnect, Microsoft.MSPaint, Microsoft.WindowsCamera,
    Microsoft.ScreenSketch, Microsoft.WindowsAlarms, Microsoft.WindowsMaps,
    Microsoft.SoundRecorder, Microsoft.WindowsFeedbackHub, Microsoft.Todos,
    Microsoft.Whiteboard, Microsoft.SkypeApp, Microsoft.549981C3F5F10,
    Microsoft.3DBuilder, Microsoft.WindowsCommunicationsApps, Microsoft.Office.OneNote,
    Microsoft.MicrosoftStickyNotes, Microsoft.PowerAutomateDesktop,
    Microsoft.WindowsSoundRecorder, Microsoft.Clipchamp, Microsoft.WindowsNotepad,
    Microsoft.WindowsCalculator, Microsoft.Edge, Microsoft.Copilot
) do (
    powershell -Command "Get-AppxPackage -Name %%i -AllUsers | Remove-AppxPackage -AllUsers -ErrorAction SilentlyContinue"
    powershell -Command "Get-AppxProvisionedPackage -Online | Where-Object { $_.DisplayName -like '%%i' } | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue"
)

:: Unpin all Taskbar and Start items
powershell -Command "$p='HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband';Remove-Item $p -Recurse -Force -ErrorAction SilentlyContinue"
del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\*" /s /q >nul 2>&1

:: Restart Explorer to apply GUI changes
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 >nul
start explorer.exe

:: Download and set wallpaper (you can replace this link)
set "wallpaperURL=https://images.unsplash.com/photo-1604079628045-94302c1be051"
set "wallpaperPath=%TEMP%\bg.jpg"

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%wallpaperURL%', '%wallpaperPath%')"
powershell -Command "Add-Type -TypeDefinition 'using System.Runtime.InteropServices;public class Wallpaper{[DllImport(\"user32.dll\",SetLastError=true)]public static extern bool SystemParametersInfo(int uAction,int uParam,string lpvParam,int fuWinIni);}' ; [Wallpaper]::SystemParametersInfo(20, 0, '%wallpaperPath%', 3)"

:: Done
exit

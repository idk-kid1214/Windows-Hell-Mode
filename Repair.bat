@echo off
title Restore Windows
color 2
cls
echo Restoring system...
timeout /t 3 >nul

:: Find the external backup drive
for %%d in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\HiddenBackup\" (
        set backupDrive=%%d:\HiddenBackup\
        goto foundBackup
    )
)
echo No backup found! System restore failed.
pause
exit

:foundBackup
:: Restore system from backup
wbadmin start recovery -backupTarget:%backupDrive% -include:C:

:: Re-enable WiFi and Bluetooth
powershell -Command "Get-NetAdapter | Where-Object {$_.InterfaceDescription -match 'Wi-Fi'} | Enable-NetAdapter -Confirm:$false"
powershell -Command "Get-NetAdapter | Where-Object {$_.InterfaceDescription -match 'Bluetooth'} | Enable-NetAdapter -Confirm:$false"

:: Re-enable CMD, Task Manager, Regedit, and Control Panel
reg delete "HKCU\Software\Policies\Microsoft\Windows\System" /v DisableCMD /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableTaskMgr /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\System" /v DisableRegistryTools /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v NoControlPanel /f

:: Re-enable Recovery Mode
bcdedit /set {current} recoveryenabled yes

:: Delete meme hell folder
rd /s /q C:\Windows\MemeHell

:: Remove prank from startup
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v MemeHell /f

:: Exit quietly
exit

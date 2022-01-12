@echo off
:handles
Color 6
REM In.
REM 9j28gnr
REM Out.
set server=##SERVER IP WITH HELD FROM GITHUB##\LaunchCraft\
set back-server-folder=##SERVER IP WITH HELD FROM GITHUB##\users\%username%
set server-map=T:
set installed=%appdata%\.minecraft
set V=A01.1
set name=Minecraft Launcher %V%
title %name%
cls

:notice
echo.
echo Please make sure you have nothing is mapped to the T drive.
echo This launcher uses this drive because it's at the center of the
echo letters and we think this letter wouldn't be used for anything else.
echo.
echo If your ready!
pause

:again
:server
cls
NET USE %server-map% %server%\information /P:No /user:launchcraft ##passwordwithheld##
echo.
echo Is there a server?
echo.
IF EXIST "%server-map%\is-server.txt" (goto V-Check) ELSE (goto Fail)

:V-Check
cls
echo Checking version
IF EXIST "%server-map%\%V%.txt" (echo Match) ELSE (goto GetUpdate)
goto continue

:Fail
NET USE %server-map% /DELETE /Y
cls
echo Checking of the version failed.
echo This could be due to not be connected to the internet.
echo Please check your internet connection and try again.
echo After checking your connection,
pause
goto again

:GetUpdate
cls
echo Getting the new launcher version.
echo.
IF EXIST "%server-map%\update.zip" (goto UpdateNow) ELSE (goto FailUpdate)
REM .In
REM It should now be downloading the update.
REM .Out

:FailUpdate
NET USE %server-map% /DELETE /Y
cls
echo Checking for updates failed.
echo This could be due to connection problem to the internet or an issue with our update server.
echo Please check your internet connection and try again.
echo After checking your connection,
pause
goto GetUpdate

:UpdateNow
cls
CALL "%server-map%\update.bat"
goto continue

:run-backup
cls
REM NEW USE HERE IS READ ONLY USER
NET USE %server-map% %back-server-folder% /P:No /P:No /user:auth ##passwordwithheld##
IF EXIST "%server-map%\auth.txt" (echo Authorised) ELSE (goto self-backup)
IF EXIST "%server-map%\logs" (echo found) ELSE (MD %server-map%\logs)
type NUL > %server-map%\logs\backup-started--%computername%--%date:~4,2%-%date:~7,2%-%date:~-2,2%.txt
REM In. -- Folders
MD %server-map%\worlds
MD %server-map%\worlds\%date:~10%
MD %server-map%\worlds\%date:~10%\%date:~7,2%
MD %server-map%\worlds\%date:~10%\%date:~7,2%\%date:~4,2%
REM Out. -- Folders
XCOPY "%installed%\saves"/S /R /V /Y /Z "%server-map%\worlds\%date:~10%\%date:~7,2%\%date:~4,2%\"
type NUL > %server-map%\logs\backup-finished--%computername%--%date:~4,2%-%date:~7,2%-%date:~-2,2%.txt
NET USE %server-map% /DELETE /Y
exit

:self-backup
NET USE %server-map% /DELETE /Y
MD C:\Minecraft\worlds
MD C:\Minecraft\worlds\%date:~10%
MD C:\Minecraft\worlds\%date:~10%\%date:~7,2%
MD C:\Minecraft\worlds\%date:~10%\%date:~7,2%\%date:~4,2%
XCOPY "%installed%\saves"/S /R /V /Y /Z "C:\Minecraft\worlds\%date:~10%\%date:~7,2%\%date:~4,2%\"
exit

:continue
cls
NET USE %server-map% /DELETE /Y
IF EXIST "C:\Program Files (x86)\Minecraft\MinecraftLauncher.exe" () ELSE (goto NoGame)
cls
start "Lauching; %name%" "C:\Program Files (x86)\Minecraft\MinecraftLauncher.exe"
echo Starting Minecraft...Only Close This When You've Finshed Playing!
echo  As This Will Stop The Worlds Backing Up.
pause
goto run-backup

:NoGame
Echo.
echo Minecraft is not installed,
echo please install it from the Minecrat
echo website, or copy this link.
echo.
echo https://launcher.mojang.com/download/MinecraftInstaller.msi
echo.
echo Launch will exit afer you press any key.
echo.
echo.
echo.
pause
exit
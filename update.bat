@echo off
:handles
Color 6
set IP=##SERVER IP WITH HELD FROM GITHUB##
set server=\LaunchCraft\
set back-server-folder=##SERVER IP WITH HELD FROM GITHUB##\users\%username%
set server-map=T:
set installed=%appdata%\.minecraft
set LauncherVersion=A01.2
set V=A01.0
set name=Launcher Updater %V%
title %name%
cls

:start
:ZipDown
cls
REM .In
REM Starting the download again
REM .Out
NET USE %server-map% /DELETE /Y
NET USE %server-map% %server%\updates\ /P:No /user:launchcraft ##passwordwithheld##
echo Getting the new version, depending on your internet this could be a while.
echo After it has compleated it will automatically continue!
MD C:\Minecraft\updates
XCOPY "%server-map%\update-%LauncherVersion%.zip" /q "C:\Minecraft\updates"
goto UnZip

:UnZip
cls
REM .In
REM Going to unzip the file.
REM .Out
Expand "C:\Minecraft\updates\update-%LauncherVersion%.zip"
del "C:\Minecraft\updates\update-%LauncherVersion%.zip"
MOVE "C:\Minecraft\updates\*.*" /q "C:\Minecraft"
RD "C:\Minecraft\updates"
cls
EXIT /B
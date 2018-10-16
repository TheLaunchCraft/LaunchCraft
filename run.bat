@echo off
:handles
Color 6
set server=##SERVER IP WITH HELD FROM GITHUB##
set back-server=##SERVER IP WITH HELD FROM GITHUB##
set server-map=T:\
set installed=%appdata%\.minecraft\
set V=A01
set name=Minecraft Launcher %V%
title %name%
cls

:notice
echo Please make sure you have nothing mapped to your T drive.
echo This launcher uses this drive because it's at the center of the letters,
echo and we think this letter would not be used for anything else.
echo.
echo If your ready to continue,
pause
goto server-map


:server-map
NET USE T: %server%\backup\ /P:No
goto server

:server
cls
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
cls
echo Checking of the version failed.
echo This could be due to not be connected to the internet.
echo Please check your internet connection and try again.
echo After checking your connection, press anykey to try again.
pause
goto handles

:GetUpdate
cls
echo Getting the new launcher version.
echo.
IF EXIST "%server-map%\update.zip" (goto ZipDown) ELSE (goto UnZip)
REM .In
REM Should be downloading the new version.
REM .Out

:continue
cls
NET USE T: /DELETE /Y

:run-backup
cls
NET USE T: %server%\backup\%username% /P:No
cd %installed%
XCOP
NET USE T: /DELETE /Y

:ZipDown
cls
REM .In
REM Starting the download again
REM .Out
NET USE T: /DELETE /Y
NET USE T: %server%\backup\ /P:No
echo Getting the new version, depending on your internet this could be a while.
echo After it has compleated it will automatically continue!
XCOPY "%server-map%\update.zip" /q "C:\Minecraft\"
goto UnZip

:UnZip
cls
REM .In
REM Going to unzip the file.
REM .Out
Expand C:\Minecraft\minecraft.zip
XCOPY "C:\Minecraft\" /q "%appdata%\.minecraft\"

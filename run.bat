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

:server-map
NET USE T: %server%\backup\gfalaunchcraft\
goto server

:server
echo.
echo Is there a server?
echo.
IF EXIST "%server-map%\is-server.txt" (goto V-Check1) ELSE (goto V-Check2)

:V-Check1
cls
echo Checking version
IF EXIST "%server-map%\%V%.txt" (echo Match) ELSE (goto GetUpdate1)

:V-Check2
::VCheck.ftp
cls
echo Checking version
IF EXIST "\%V%.txt" (echo Match) ELSE (goto GetUpdate2)
goto run

:GetUpdate2
cls
echo Getting the new minecraft version.
echo.
IF EXIST "%server-map%\minecraft.zip" (goto ZipDown) ELSE (goto UnZip)
REM .In
REM Should be downloading the new version.
REM .Out

:continue


:ZipDown
REM .In
REM Starting the download again
REM .Out
XCOPY /q ##DOWNLOAD ZIP WITH HELD FROM GITHUB##
goto UnZip

:UnZip
REM .In
REM Going to unzip the file.
REM .Out
MOVE "C:\Users\%username%\Downloads\minecraft.zip" /q "C:\Minecraft\"
Expand C:\Minecraft\minecraft.zip
XCOPY "C:\Minecraft\" /q "%appdata%\.minecraft\"
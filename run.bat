@echo off
:handles
Color 6
set server=##SERVER NAME WITH HELD FROM GITHUB##
set installed=%appdata%\.minecraft\
set V=1.0
set name=Minecraft Launcher %V%
title %name%
cls

:server?
echo.
echo Is there a server?
echo.
IF EXIST "%server%\Minecraft\" (goto V-Check1) ELSE (goto V-Check2)

:V-Check1
cls
echo Checking version
IF EXIST "%server%\Minecraft\%V%.txt" (echo Match) ELSE (goto GetUpdate1)

:V-Check2
::VCheck.ftp
cls
echo Checking version
REM .In
REM FTP -S:VCheck.ftp [ftp.gamingforaustralia.com.au]
REM .Out
IF EXIST "\%V%.txt" (echo Match) ELSE (goto GetUpdate2)
goto run

:GetUpdate2
::GetFiles.ftp
cls
echo Getting the new minecraft version.
echo.
FTP -S:Getfiles.ftp [## NEW SERVER WITH HELD FROM GITHUB##]
IF EXIST "\minecraft.zip" (goto ZipDown) ELSE (goto UnZip)
REM .In
REM Should be download the new version.
REM .Out

:continue


:ZipDown
REM .In
REM Starting the download again
REM .Out
start ##DOWNLOAD ZIP WITH HELD FROM GITHUB##
goto UnZip

:UnZip
REM .In
REM Going to unzip the file.
REM .Out
MOVE "C:\Users\%username%\Downloads\minecraft.zip" /q "C:\Minecraft\"
Expand C:\Minecraft\minecraft.zip
XCOPY "C:\Minecraft\" /q "%appdata%\.minecraft\"
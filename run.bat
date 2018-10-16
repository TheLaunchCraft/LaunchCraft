@echo off
:handles
Color 6
set server=##SERVER IP WITH HELD FROM GITHUB##\backup
set back-server-folder=##SERVER IP WITH HELD FROM GITHUB##\backup\users\%username%\
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
goto server

REM In.
REM server-map-info
REM NET USE T: %server% /P:No
REM Out.

:server
cls
NET USE T: %server%\information\ /P:No /user:##username and password withheld##
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
NET USE T: /DELETE /Y
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
REM It should now be downloading the update.
REM .Out


:continue
cls
NET USE T: /DELETE /Y
REM In.
REM Enter rest of code to start the game here
REM Out.


:run-backup
cls
NET USE T: %back-server-folder% /P:No
IF EXIST "%server-map%auth.txt" (echo Authorised) ELSE (goto self-backup)
"T:\zipper.vbs" "%installed%\saves\" "T:\worlds\worlds-%date:~4,2%-%date:~7,2%-%date:~-2,2%.zip"
XCOPY
NET USE T: /DELETE /Y
:self-backup
NET USE T: /DELETE /Y
:zipper
IF EXIST "C:\zipper.vbs" (goto Zip) ELSE (goto grab-zipper)
:grab-zipper
NET USE T: %server%\information\
XCOPY "T:\zipper.vbs" /q "C:\Minecraft\"
NET USE T: /DELETE /Y
:Zip
"C:\zipper.vbs" "C:\folderToZip\" "C:\mynewzip.zip"
XCOPY`

:ZipDown
cls
REM .In
REM Starting the download again
REM .Out
NET USE T: /DELETE /Y
NET USE T: %server%\updates\ /P:No
echo Getting the new version, depending on your internet this could be a while.
echo After it has compleated it will automatically continue!
XCOPY "%server-map%\update.zip" /q "C:\Minecraft\"
goto UnZip

:UnZip
cls
REM .In
REM Going to unzip the file.
REM .Out
Expand C:\Minecraft\update.zip
del "update.zip"
XCOPY "C:\Minecraft\" /q "%appdata%\.minecraft\"

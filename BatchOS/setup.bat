@echo off
title BatchOS Setup
color 17

:BEGIN
cls
echo Setup will begin after an automatic file integrity check. Proceed?
set /p input=Y/N: 
if %input%==Y goto DAT if NOT exit
if %input%==y goto DAT if NOT exit
if %input%==N exit 
if %input%==n exit
if %input%==debug goto MENU
goto BEGIN

:DAT
cls
if not exist 1.pkg set file_missing=1.pkg & set spaces=                           & goto FAIL
if not exist 2.pkg set file_missing=2.pkg & set spaces=                           & goto FAIL
if not exist 3.pkg set file_missing=3.pkg & set spaces=                           & goto FAIL
if not exist 4.pkg set file_missing=4.pkg & set spaces=                           & goto FAIL
cls
echo File integrity has been verified. Proceeding... 
ping localhost -n 2 >nul & goto MENU

:FAIL
cls
color 47
echo Sorry, one or more required files are missing. Please re-download from the source.
echo Missing file reported: %file_missing%%spaces%
echo.
pause
exit


:MENU
cls
color 17      
echo BatchOS 1.0 Standard Edition Setup - Alpha Development Build 1000
echo Select an item from the menu and press ENTER to continue.
echo.
echo 1 - Install               
echo 2 - Information
echo 3 - Exit           
echo.
set /p input=Input option choice: 
if %input%==1 goto INST if NOT exit
if %input%==2 goto INFO if NOT exit
if %input%==3 goto exit if NOT exit
if %input%==4 goto OEM if NOT exit
if %input%==5 goto PRE1 if NOT exit
echo Invalid choice, please input the number corresponding to your desired option.
pause
goto MENU

:INST
cls
echo BATCHOS SETUP
echo.
echo Welcome to the setup for BatchOS, a mini-OS designed for Windows-based Command Prompt.
echo This setup will guide you to configure your desired options for the installation of this OS.
echo Would you like to continue or cancel and go back to the main menu?
echo.
choice /N /C:12 /M "1 - CONTINUE / 2 - BACK"%1
IF ERRORLEVEL ==2 GOTO MENU
IF ERRORLEVEL ==1 GOTO INST1
exit

:INST1
cls
echo SYSTEM REQUIREMENTS
echo.
echo Before installation, please ensure that the following minimum specifications are met:
echo.
echo Host OS: Microsoft Windows XP/Vista/7/8/8.1/10
echo Memory: 1GB
echo Storage: 50MB
echo.
echo The following recommended specifications can be optionally met:
echo.
echo Network: Broadband connection to the Internet (required for certain features/programs)
echo.
echo NOTE: BatchOS is best experienced on Windows 7 and newer. The more recent, the better.
echo.
choice /n /c:12 /m "1 - CONTINUE / 2 - BACK"%1
if errorlevel ==2 goto INST
if errorlevel ==1 goto INST2
exit

:INST2
cls
echo INSTALL LOCATION
echo.
echo Please specify the path where you want BatchOS installed. The recommended location is "C:\BatchOS".
echo.
set /p loc=
echo.
echo Your selected install location is %loc% - Confirm?
if not exist "%loc%" (
    mkdir "%loc%" 2>nul
    if not errorlevel 1 (
        echo VALID >nul
    )
) 
choice /n /c:12 /m "1 - YES / 2 - NO"%1
if errorlevel ==2 goto INST2
if errorlevel ==1 goto INST3
exit

:INST2ALT
cls
echo INSTALL LOCATION
echo.
echo Please specify the path where you want BatchOS installed. The recommended location is "C:\BatchOS".
echo.
set /p loc=
echo.
echo Your selected install location is %loc% - Confirm?
if not exist "%loc%" (
    mkdir "%loc%" 2>nul
    if not errorlevel 1 (
        echo VALID >nul
    )
) 
choice /n /c:12 /m "1 - YES / 2 - NO"%1
if errorlevel ==2 goto INST2
if errorlevel ==1 goto INST5
exit

:INST3
cls
echo LICENSE
echo.
echo    BatchOS - Copyright (C) 2021  David Costell
echo.
echo    This program is free software: you can redistribute it and/or modify
echo    it under the terms of the GNU General Public License as published by
echo    the Free Software Foundation, either version 3 of the License, or
echo    (at your option) any later version.
echo.
echo    This program is distributed in the hope that it will be useful,
echo    but WITHOUT ANY WARRANTY; without even the implied warranty of
echo    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
echo    GNU General Public License for more details.
echo.
echo    You should have received a copy of the GNU General Public License
echo    along with this program.  If not, see https://www.gnu.org/licenses.
echo.
echo BatchOS is licensed under GNU GPL version 3.
echo To continue installation, you must read and agree to its terms and conditions.
echo.
pause
cls
start license.txt 
echo LICENSE
echo.
echo Do you agree to the terms and conditions?
choice /n /c:12 /m "1 - I AGREE / 2 - I DISAGREE"%1
if errorlevel ==2 exit
if errorlevel ==1 goto INST4
exit

:INST4
cls
echo NETWORK CONNECTION 
echo.
echo For certain functions and programs, BatchOS will need access to the Internet.
echo Setup will now attempt to ping two IP addresses to test your Internet connection.
pause
cls
ping -n 1 -l 1000 1.1.1.1 
ping -n 1 -l 1000 8.8.8.8
ping localhost -n 4 >nul
cls
echo If both ping requests timed out, you most likely have no connection to the Internet.
echo Some features and programs of BatchOS require access to the Internet to properly function.
echo.
echo If you have a working Internet connection but one or both requests timed out, it is
echo likely your connection's speed is slow or throttled. This will not affect Internet-requiring
echo features and programs of BatchOS except in very intensive workloads.
echo.
echo Regardless of your internet connection's status, you will always be able to use the core functionality of BatchOS.
echo.
choice /n /c:12 /m "1 - CONTINUE / 2 - PING AGAIN"%1
if errorlevel ==2 goto INST4
if errorlevel ==1 goto INST5
exit

:INST5
cls
echo Finalization
echo.
echo Setup is nearly ready to begin the installation process. Once again, confirm that you:
echo.
echo -Meet the minimum system requirements for BatchOS.
echo -Agree to the GNU General Public License v3 applied to this program.
echo -Are ready to begin the installation process itself. 
echo.
echo Your configured installation directory is %loc%
echo Are you sure you wish to begin the setup's installation process?
echo.
choice /n /c:123 /m "1 - BEGIN INSTALLATION / 2 - CANCEL AND RETURN TO MENU / 3 - CHANGE INSTALLATION DIRECTORY"%1
if errorlevel ==3 goto INST2ALT
if errorlevel ==2 goto MENU
if errorlevel ==1 goto GO
exit

:GO
cls
echo INSTALLATION 
echo.
ren 1.pkg 1.zip
ren 2.pkg 2.zip
ren 3.pkg 3.zip
ren 4.pkg 4.zip
mkdir C:\BatchTemp
xcopy *.zip C:\BatchTemp
cls
Call :UnZipFile "C:\ExtractTemp" "C:\BatchTemp\1.zip"
echo First archive extracted.
ping localhost -n 2 >nul
Call :UnZipFile "C:\ExtractTemp" "C:\BatchTemp\2.zip"
echo Second archive extracted.
ping localhost -n 2 >nul
Call :UnZipFile "C:\ExtractTemp" "C:\BatchTemp\3.zip"
echo Third archive extracted.
ping localhost -n 2 >nul
cd C:\BatchTemp
ren 4.zip batchos.bat
move /y batchos.bat C:\ExtractTemp >nul
cls
echo Installing... 
xcopy /i C:\ExtractTemp %loc% >nul
ping localhost -n 3 >nul
echo.
echo BatchOS has been installed successfully.
echo Installed at %loc%
echo.
rmdir /s /q C:\ExtractTemp >nul
choice /n /c:123 /m "1 - EXIT INSTALLER / 2 - OPEN INSTALLATION FOLDER / 3 - READ THE INFO"%1
if errorlevel ==3 goto INFOALT 
if errorlevel ==2 goto Pre1  
if errorlevel ==1 goto Pre2
exit 

:Pre1
cls
rmdir /s /q C:\BatchTemp >nul
cls
goto Pre1A

:Pre1A
start %loc%

:Pre2
cls
rmdir /s /q C:\BatchTemp >nul
cls
exit

:INFO
cls
echo BatchOS 1.0 Alpha - Standard Edition 
echo July 2021
echo Development Build 1000 
echo.
echo A mini-OS developed within the limits of the Batch language.
echo This project is under heavy development.
echo For a smoother experience, install BatchOS on a host machine
echo with Windows 7 or a newer operating system.
pause >nul
goto MENU

:INFOALT
cls
echo BatchOS 1.0 Alpha - Standard Edition 
echo July 2021
echo Development Build 1000 
echo.
echo A mini-OS developed within the limits of the Batch language.
echo This project is under heavy development.
echo For a smoother experience, install BatchOS on a host machine
echo with Windows 7 or a newer operating system.
pause >nul
exit

REM OEM mode is unsupported and has not yet been developed!
:OEM
color 47
cls
echo Support for OEM installation is not yet implemented.
pause
goto MENU

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%
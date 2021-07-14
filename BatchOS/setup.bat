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
goto BEGIN

:DAT
cls
if not exist 1.pkg set file_missing=1.pkg & set spaces=                           & goto FAIL
if not exist 2.pkg set file_missing=2.pkg & set spaces=                           & goto FAIL
if not exist 3.pkg set file_missing=3.pkg & set spaces=                           & goto FAIL
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
echo BatchOS 1.0 Standard Edition Setup - Alpha Build 1000
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
if %input%==5 goto INST5 if NOT exit
echo Invalid choice, please input the number corresponding to your desired option.
pause
goto MENU

:INST
cls
echo BATCHOS SETUP
echo.
echo Welcome to the setup for BatchOS, a mini-OS designed for Windows-based Command Prompt.
echo This setup will guide you to configure your desired options for installation of this OS.
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
echo Storage: 75MB
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
set /p location=
echo.
echo Your selected install location is %location% - Confirm?
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
set /p location=
echo.
echo Your selected install location is %location% - Confirm?
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
echo Your configured installation directory is %location%
echo Are you sure you wish to begin the setup's installation process?
echo.
choice /n /c:123 /m "1 - BEGIN INSTALLATION / 2 - CANCEL AND RETURN TO MENU / 3 - CHANGE INSTALLATION DIRECTORY"%1
if errorlevel ==3 goto INST2ALT
if errorlevel ==2 goto MENU
if errorlevel ==1 goto GO
exit
pause
exit

:GO
cls
echo INSTALLATION 
echo.
echo Work in progress.
setlocal
for /f "tokens=2 delims=[]" %%i in ('ver') do set VERSION=%%i
for /f "tokens=2-3 delims=. " %%i in ("%VERSION%") do set VERSION=%%i.%%j
if "%VERSION%" == "5.1" echo Windows XP >nul & goto OTHER 
if "%VERSION%" == "6.0" echo Windows Vista >nul & goto OTHER
if "%VERSION%" == "6.1" echo Windows 7 >nul & goto OTHER
if "%VERSION%" == "6.2" echo Windows 8 >nul & goto PS
if "%VERSION%" == "6.3" echo Windows 8.1 >nul & goto PS 
if "%VERSION%" == "6.4" echo Windows 10 >nul & goto PS10
if "%VERSION%" == "10.0" echo Windows 10 >nul & goto PS10
endlocal 
pause
exit
REM July 14 2021 - Classifications
REM PS10 - For Windows 10. This means BatchOS Setup can use PowerShell unzipping method normally.
REM PS - For Windows 7 up to 8.1 - This means BatchOS Setup will have to download PowerShell 5.0 to unzip.
REM OTHER - For older Windows versions. Will have to find an alternate way to unzip...



:INFO
cls
echo BatchOS 1.0 Alpha - Standard Edition 
echo July 2021
echo Build 1000
echo.
echo A mini-OS within the limits of the Batch language.
echo Full compatibility with Windows Vista and newer.
echo Some features may not work as intended on Windows XP
pause >nul
goto MENU

REM OEM mode is unsupported and has not yet been developed!
:OEM
color 47
cls
echo Support for OEM installation is not yet implemented.
pause
goto MENU

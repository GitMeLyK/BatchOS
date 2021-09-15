@echo off
set color=Placeholder
findstr /c:"0a" dsgn.mode
if %ERRORLEVEL%==0 set color=0a
if %ERRORLEVEL%==1 set color=17
set /p path=<confi.g
set /p CustomMessage=<confi.g2
for /F "tokens=2" %%i in ('date /t') do set mydate=%%i
set mytime=%time%
title LogTool
::color 0a
goto MENU
:MENU
cls
color %color%
cls
echo LogTool v1
echo Build developed July 13 2021
echo.
echo Running as Administrator is recommended.
echo Instructions and more can be found in Info.
echo ------------------------------------------------------------------------------------------
echo 1 - Log
echo 2 - Options
echo 3 - Info
echo 4 - Exit
set input=
set /p input= Input choice and press Enter: 
if %input%==1 goto REG if NOT goto MENU
if %input%==2 goto OPT if NOT goto MENU
if %input%==3 goto CRE if NOT goto MENU
exit
:REG
cls
echo Are you sure you want to register a log? If yes,
pause 
echo Entry logged!>>%path%
echo "%CustomMessage%">>%path%
echo %mytime%, %mydate%>>%path%
echo ⠀>>%path%
if not exist %path% cls & color 0c & echo ERROR: Log failed! Press any key to return to MENU.
if exist %path% echo Log successfully performed.
pause >nul
goto MENU 
:OPT
cls
echo 1 - Change save path of log file
echo 2 - Add custom message to entry
echo 3 - Switch color schema
echo 4 - Exit to main menu
set input=
set /p input= Input choice and press Enter: 
if %input%==1 goto OPT1 if NOT goto MENU
if %input%==2 goto OPT2 if NOT goto MENU
if %input%==3 goto CUST if NOT goto MENU
if %input%==4 goto MENU if NOT exit
exit
:OPT1
cls
echo The CURRENT directory is %path%
echo Would you like to change it?
set input=
set /p input= Y/N: 
if %input%==Y goto OPT1A if NOT goto MENU
if %input%==y goto OPT1A if NOT goto MENU
if %input%==Yes goto OPT1A if NOT goto MENU
if %input%==yes goto OPT1A if NOT goto MENU
if %input%==N goto MENU if NOT exit
if %input%==n goto MENU if NOT exit
if %input%==No goto MENU if NOT exit
if %input%==no goto MENU if NOT exit
goto MENU
:OPT1A
cls
@echo off
set /p path= "Specify path: (e.g. D:\log.txt) "
echo The path has been set to %path% 
echo %path%>confi.g
pause
goto MENU
:OPT2
cls
echo The CURRENT custom message set is: %CustomMessage%
echo Would you like to change it?
set /p input= Y/N: 
if %input%==Y goto OPT2A if NOT goto MENU
if %input%==N goto MENU if NOT exit
goto MENU
:OPT2A
cls
@echo off
set /p CustomMessage= "Specify custom message: (e.g. Hello world!): "
setx CustomMessage "%CustomMessage%"
echo The custom message has been set to: %CustomMessage% 
echo %CustomMessage%>confi.g2
pause
goto MENU
pause
exit
:CRE
cls
echo Made by David
echo v1, Build 1400, 9/15/2021
echo ------------------------------------------------------------------------------------------
echo 1 - Bugs                          2 - Help
echo 3 - Changelog                     4 - Exit to Menu
echo 5 - Exit program
set input=
set /p input= Input choice and press Enter: 
if %input%==1 goto BUGS if NOT exit
if %input%==2 goto HELP if NOT exit
if %input%==3 goto CHG if NOT exit
if %input%==4 goto MENU if NOT exit
if %input%==5 exit
goto CRE
:BUGS
cls
@echo off
color 0c
echo KNOWN BUGS:
echo -%USERPROFILE% and C:\Users\%USERNAME%\ variables not working for destination directory
echo definition.
echo ------------------------
echo Please e-mail veryrisible@gmail.com if you see a bug to report it.
pause
goto CRE
:HELP
cls
@echo off
echo LogTool Help
echo ------------------------
echo Welcome to LogTool! This tool is intended to help you manage your time automating the
echo creation of text files to store log entries on. This help section aims to clarify the
echo function of this tool. Read on to learn more!
pause
cls
echo LogTool Introduction
echo ------------------------
echo LogTool works through the use of definitions. What are these definitions? They are
echo important information LogTool needs to successfully perform. There are two of them. First,
echo the destination directory. Second, the message to put in the entry. These two definitions
echo are easily changeable through the OPTIONS. Let's learn about the options menu!
pause
cls
echo LogTool Options
echo ------------------------
echo Upon launching the program, you are presented with three input choices. The OPTIONS menu
echo is one of them. Once you navigate to it, there are two configurable settings presented.
echo It is through these options you can customize the aforementioned definitions. First, the:
echo ------------------------
echo DESTINATION DIRECTORY
echo The destination directory is where LogTool puts your files. On first time use, this is
echo defined to your root folder (C:\). It won't work because the tool will be denied access! echo The recommended directory is your desktop, but you can define any valid directory to the echo tool. For example:
echo ------------------------
echo C:\Users\[Account Username]\Desktop\log.txt
echo ------------------------
echo Replace [Acccount Username] with the username of the account you are currently using
echo to run and use LogTool. 
echo Don't forget to add the name of the file in the end of the path! (e.g. Mylog.txt)
echo ------------------------
echo Ready to learn about the next definition? If so,
pause
cls
echo CUSTOM MESSAGE
echo A custom message is a changeable line of text that is inserted into every entry you log. echo On first time use, this is defined as "Hello World." You can easily change this to any
echo text you desire. For example:
echo ------------------------
echo The Custom Message has been set to: It is morning, today looks great!
echo ------------------------
echo Ready to learn about logging itself? If so,
pause
cls
echo LogTool - Logging
echo ------------------------
echo This is the core feature of LogTool, as can be inferred from the name - logging. It's
echo quite straightforward. Upon program startup, input 1 and press ENTER. Then, it asks for
echo you to confirm the action in a prompt. After that, LogTool gets to work!
echo If it succeeds, you can navigate to the destination directory and see the entry.
echo If it fails, it's either because of insufficient access permissions or an invalid
echo directory. Run as administrator to fix the first problem.
pause
cls
echo LogTool - Error
echo ------------------------
echo If you encounter errors/bugs, shoot an email to veryrisible@gmail.com
echo ------------------------
echo Nearly done!
pause
echo That's LogTool explained in this handy guide. Don't hesitate to shoot an e-mail for any
echo feedback, comments, questions or bug reports. Have a nice day.
pause
goto CRE
:CHG
cls
@echo off
echo Build 1400
echo -------------------------------------
echo This is a stopgap update to v1.1 - stay tuned!
echo Adjusted some stuff in the help guide
echo Added an option to switch between color schemas.
echo -------------------------------------
pause
goto CRE
:CUST
cls
echo Switch color schemas
echo.
echo 1 - Black and green
echo 2 - Blue and white
echo 3 - Exit to main menu
echo.
set /p input= Input choice and press Enter: 
if %input%==1 echo 0a>dsgn.mode && set color=0a && goto MENU
if %input%==2 echo 17>dsgn.mode && set color=17 && goto MENU
if %input%==3 goto MENU
exit
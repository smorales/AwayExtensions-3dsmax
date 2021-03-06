@echo off
echo.
set programmname=3dsmax 2011 64 bit
echo AwayExtensions-3dsmax Installer for %programmname%
echo.
echo.
echo Detected pathes:
echo.
set programmpath=%ProgramFiles%\Autodesk\3ds Max 2011\
if %PROCESSOR_ARCHITECTURE%==x86 (goto exitWrongProcessor)

::Do not use the env var for 2011 as it starts with a Number, and therefore does not work
::IF DEFINED 3DSMAX_2011x64_PATH (set programmpath=%3DSMAX_2011x64_PATH%)

set exportername=maxawdexporter_2011_64.dle
set toolbarname=AWDToolBar_2011_2012.CUI

if EXIST "%programmpath%" (echo  - programm:  "%programmpath%") ELSE (goto exitNo3dspath)
if not EXIST "%programmpath%3dsmax.exe" (goto exitNo3dsexe)
set pluginsPath=%programmpath%plugins\
if EXIST "%pluginsPath%" (echo  - plugins:  "%pluginsPath%") ELSE (goto exitNoPluginsPath)
set localUIpath=%LOCALAPPDATA%\Autodesk\3dsMax\2011 - 64bit\enu\UI\
if EXIST "%localUIpath%" (echo  - local-UI: "%localUIpath%") ELSE (goto exitNoLocalUI)
set macrosPath=%localUIpath%usermacros\
if EXIST "%macrosPath%" (echo  - usermacros: local-UI + "\usermacros") ELSE (goto exitNoUserMacros)
set iconsPath=%localUIpath%usericons\
if EXIST "%iconsPath%" (echo  - usericon:   local-UI + "\usericons") ELSE (goto exitNoUserIcons)
set uiPath=%programmpath%UI\
if EXIST "%uiPath%" (echo  - UI: "%uiPath%") ELSE (goto exitNoUI)

echo.
echo.
goto checkif3dsmaxruns
exit /b

:checkIfExists
   if EXIST "%macrosPath%\AWDCommands\" (goto askForUninstall)
   if EXIST "%pluginsPath%AwayExtensions3dsMax\" (goto askForUninstall)
   if EXIST "%pluginsPath%%exportername%" (goto askForUninstall)
   if EXIST "%iconsPath%\AwayExtensionIcons_16a.bmp" (goto askForUninstall)
   if EXIST "%iconsPath%\AwayExtensionIcons_16i.bmp" (goto askForUninstall)
   if EXIST "%iconsPath%\AwayExtensionIcons_24a.bmp" (goto askForUninstall)
   if EXIST "%iconsPath%\AwayExtensionIcons_24i.bmp" (goto askForUninstall)
   if EXIST "%iconsPath%\AWDAbout.bmp" (goto askForUninstall)
   if EXIST "%uiPath%%toolbarname%" (goto askForUninstall)

   set /p answer=Install AwayExtensions for %programmname% (Y/N)?
   if /i "%answer:~,1%" EQU "Y" goto install
   exit /b
   
:askForUninstall
   set /p answer=Remove AwayExtensions 3dsmax ? (press y to proceed)
   if /i "%answer:~,1%" EQU "y" goto remove
   echo No valid input!
   goto askForUninstall


:checkif3dsmaxruns
   tasklist /FI "imagename eq 3dsmax.exe" 2>NUL | find /I /N "3dsmax.exe">NUL && (goto asktoexit3dsmax)||(goto checkIfExists)


:asktoexit3dsmax
   echo 3dsmax appears to be running. Please exit all running 3dsmax-applications!
   pause
   tasklist /FI "imagename eq 3dsmax.exe" 2>NUL | find /I /N "3dsmax.exe">NUL && (goto asktoexit3dsmax)||(goto checkIfExists)

:remove
   echo.
   echo      Start Uninstallation
   if EXIST "%macrosPath%\AWDCommands\" (rmdir /s /q "%macrosPath%\AWDCommands\") ELSE (echo "Folder: AWDCommands could not be found in usermacros")
   if EXIST "%iconsPath%\AwayExtensionIcons_16a.bmp" (del /q "%iconsPath%\AwayExtensionIcons_16a.bmp") ELSE (echo "File: AwayExtensionIcons_16a.bmp could not be found in usericons")
   if EXIST "%iconsPath%\AwayExtensionIcons_16i.bmp" (del /q "%iconsPath%\AwayExtensionIcons_16i.bmp") ELSE (echo "File: AwayExtensionIcons_16i.bmp could not be found in usericons")
   if EXIST "%iconsPath%\AwayExtensionIcons_24a.bmp" (del /q "%iconsPath%\AwayExtensionIcons_24a.bmp") ELSE (echo "File: AwayExtensionIcons_24a.bmp could not be found in usericons")
   if EXIST "%iconsPath%\AwayExtensionIcons_24i.bmp" (del /q "%iconsPath%\AwayExtensionIcons_24i.bmp") ELSE (echo "File: AwayExtensionIcons_24i.bmp could not be found in usericons")
   if EXIST "%iconsPath%\AWDAbout.bmp" (del /q "%iconsPath%\AWDAbout.bmp")ELSE (echo "File: AWDAbout.bmp could not be found in usericons")
   if EXIST "%pluginsPath%%exportername%" (del /q "%pluginsPath%%exportername%") ELSE (echo "File: %exportername% could not be found in plugin folder")
   if EXIST "%uiPath%%toolbarname%" (del /q "%uiPath%%toolbarname%") ELSE (echo "File: %toolbarname% could not be found in the UI folder")
   if EXIST "%pluginsPath%AwayExtensions3dsMax\" (rmdir /s /q "%pluginsPath%AwayExtensions3dsMax\") ELSE (echo "Folder: AwayExtensions3dsMax could not be found in plugin folder")
   echo.
   echo      Uninstallation complete
   echo.
   set /p answer=Press ENTER to close this window... 
   exit /b
   
:exitNo3dspath
   echo !!!Could not find the 3dsmax system path. Installation cancelled!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitNoPluginsPath
   echo !!!Could not find the 3dsmax plugin path. Installation cancelled!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitNoUserMacros
   echo !!!Could not find the 3dsmax usermacros folder. Installation cancelled!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitNoUserIcons
   echo !!!Could not find the 3dsmax userIcons folder. Installation cancelled!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitNoUI
   echo !!!Could not find the 3dsmax UI path. Installation cancelled!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitNoLocalUI
   echo !!!Could not find the local 3dsmax UI path. Installation cancelled!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitNo3dsexe
   echo !!!Could not find the 3dsmax.exe for %programmname%!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
   

   echo      Start Uninstallation
   if EXIST "%macrosPath%\AWDCommands\" (rmdir /s /q "%macrosPath%\AWDCommands\") ELSE (echo "Folder: AWDCommands could not be found in usermacros")
   if EXIST "%iconsPath%\AwayExtensionIcons_16a.bmp" (del /q "%iconsPath%\AwayExtensionIcons_16a.bmp") ELSE (echo "File: AwayExtensionIcons_16a.bmp could not be found in usericons")
   if EXIST "%iconsPath%\AwayExtensionIcons_16i.bmp" (del /q "%iconsPath%\AwayExtensionIcons_16i.bmp") ELSE (echo "File: AwayExtensionIcons_16i.bmp could not be found in usericons")
   if EXIST "%iconsPath%\AwayExtensionIcons_24a.bmp" (del /q "%iconsPath%\AwayExtensionIcons_24a.bmp") ELSE (echo "File: AwayExtensionIcons_24a.bmp could not be found in usericons")
   if EXIST "%iconsPath%\AwayExtensionIcons_24i.bmp" (del /q "%iconsPath%\AwayExtensionIcons_24i.bmp") ELSE (echo "File: AwayExtensionIcons_24i.bmp could not be found in usericons")
   if EXIST "%pluginsPath%AwayExtensions3dsMax\" (rmdir /s /q "%pluginsPath%AwayExtensions3dsMax\") ELSE (echo "Folder: AwayExtensions3dsMax could not be found in plugin folder")
   if EXIST "%iconsPath%\AWDAbout.bmp" (del /q "%iconsPath%\AWDAbout.bmp") ELSE (echo "File: AWDAbout.bmp could not be found in usericons")
   if EXIST "%pluginsPath%%exportername%" (del /q "%pluginsPath%%exportername%") ELSE (echo "File: %exportername% could not be found in plugin folder")
   if EXIST "%uiPath%%toolbarname%" (del /q "%uiPath%%toolbarname%") ELSE (echo "File: %toolbarname% could not be found in the UI folder")
   echo.
   echo      Uninstallation complete
   echo.
   set /p answer=Press ENTER to close this window... 
   exit /b
   
:exitNo3dspath
   echo !!!Could not find the 3dsmax system path. Installation cancelled!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitNoPluginsPath
   echo !!!Could not find the 3dsmax plugin path. Installation cancelled!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitNoUserMacros
   echo !!!Could not find the 3dsmax usermacros folder. Installation cancelled!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitNoUserIcons
   echo !!!Could not find the 3dsmax userIcons folder. Installation cancelled!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitNoUI
   echo !!!Could not find the 3dsmax UI path. Installation cancelled!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitNoLocalUI
   echo !!!Could not find the local 3dsmax UI path. Installation cancelled!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitWrongProcessor
   echo !!!Cannot install 64bit plugin on 32bit system!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
:exitNo3dsexe
   echo !!!Could not find the 3dsmax.exe for %programmname%!!!
   set /p answer=Press ENTER to close this window... 
   exit /b
   

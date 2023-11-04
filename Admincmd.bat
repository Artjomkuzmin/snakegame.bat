please open file in mode administrotor
code:

@echo off
:: Check if running with admin rights

nul 2>&1 "%SYSTEMROOT%\System32\cacls.exe" "%SYSTEMROOT%\System32\config\system"

:: If the errorlevel is 0, it means running with admin rights
if %errorlevel%==0 (
color 0A
title bconcole (Admin)
echo Running with administrator rights.

:: List disks
echo.
echo List of Disks:
wmic diskdrive get DeviceID, Model

:: Identify HDDs and SSDs
echo.
echo Identifying HDDs and SSDs:
wmic diskdrive get DeviceID, MediaType

:: Check RAM
echo.
echo RAM Information:
wmic memorychip get Capacity
wmic memorychip get Capacity /format:csv

:: Display Computer Name
echo.
echo Computer Name:
echo %COMPUTERNAME%

:: Open Task Manager
echo.
echo Opening Task Manager...
start taskmgr
) else (
color 0C
title bconcole (Standard)
echo Please run this script as an administrator.
)

:: Pause to keep the window open
pause


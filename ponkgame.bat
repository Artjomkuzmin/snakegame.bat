@echo off
setlocal enabledelayedexpansion

REM Set initial positions
set "ball_x=10"
set "ball_y=5"
set "ball_dx=1"
set "ball_dy=1"

set "paddle_x=1"
set "paddle_y=5"
set "paddle_dy=0"

REM Game loop
:game_loop
cls

REM Draw the game board
for /l %%y in (0,1,10) do (
for /l %%x in (0,1,20) do (
set "cell= "
if %%x==%paddle_x% if %%y==%paddle_y% set "cell=█"
if %%x==%ball_x% if %%y==%ball_y% set "cell=■"
echo|set /p=!cell!
)
echo.
)

REM Update the ball position
set /a "ball_x+=ball_dx"
set /a "ball_y+=ball_dy"

REM Update the paddle position
set /a "paddle_y+=paddle_dy"

REM Ball collisions
if %ball_x%==0 (
if %ball_y% geq %paddle_y% if %ball_y% leq %paddle_y%+2 (
set "ball_dx=1"
) else (
goto :game_over
)
)

if %ball_x%==19 set "ball_dx=-1"
if %ball_y%==0 set "ball_dy=1"
if %ball_y%==10 set "ball_dy=-1"

REM Move the paddle with arrow keys
choice /c WSD /n /t 0.1 /d S > nul
if errorlevel 3 set "paddle_dy=0"
if errorlevel 2 set "paddle_dy=-1"
if errorlevel 1 set "paddle_dy=1"

goto :game_loop

:game_over
echo Game over!
endlocal


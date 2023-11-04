@echo off
setlocal enabledelayedexpansion

REM Set the initial position of the snake
set "snake=10-10 10-11 10-12"
set "snake_length=3"

REM Set the initial position of the fruit
set /a "fruit_x=5"
set /a "fruit_y=5"

REM Set the initial direction of the snake (0=right, 1=down, 2=left, 3=up)
set "direction=0"

:game_loop
REM Clear the screen
cls

REM Draw the game board
for /l %%y in (0,1,15) do (
for /l %%x in (0,1,15) do (
set "cell= "
for %%s in (!snake!) do (
for %%t in (!snake_length!) do (
for /f "tokens=1,2 delims=-" %%a in ("%%s") do (
if %%x==%%a if %%y==%%b set "cell=█"
)
)
)
if %%x==!fruit_x! if %%y==!fruit_y! set "cell=■"
echo|set /p=!cell!
)
echo.
)

REM Update the snake's position
for %%s in (!snake!) do (
for /l %%t in (!snake_length!,-1,2) do (
set "segment%%t=!segment%%t!"
set "segment%%t=!segment%%t:~0,-8!"
)
)

REM Move the snake
if !direction! equ 0 (
set /a "head_x=!snake:~0,-8!+1"
set "snake=!head_x!-!snake!"
)
if !direction! equ 1 (
set /a "head_y=!snake:~2,-8!+1"
set "snake=!snake! !snake_length!-!head_y! !head_y!"
)
if !direction! equ 2 (
set /a "head_x=!snake:~0,-8!-1"
set "snake=!head_x!-!snake!"
)
if !direction! equ 3 (
set /a "head_y=!snake:~2,-8!-1"
set "snake=!snake! !head_y!-!snake_length! !head_y!"
)

REM Check for collisions with the walls or itself
for %%s in (!snake!) do (
for %%t in (!snake_length!) do (
for /f "tokens=1,2 delims=-" %%a in ("%%s") do (
if %%a lss 0 if %%a gtr 15 set "direction=2"
if %%b lss 0 if %%b gtr 15 set "direction=3"
)
)
)
for %%s in (!snake!) do (
for %%t in (!snake_length!) do (
for /f "tokens=1,2 delims=-" %%a in ("%%s") do (
for %%u in (!snake!) do (
for %%v in (!snake_length!) do (
for /f "tokens=1,2 delims=-" %%b in ("%%u") do (
if %%a==%%b if %%b==%%a if %%b==%%a if %%v neq %%t (
if %%v gtr %%t set "direction=2"
if %%v lss %%t set "direction=3"
)
)
)
)
)
)
)

REM Check if the snake ate the fruit
if !snake:~0,-8!==!fruit_x! if !snake:~2,-8!==!fruit_y! (
set /a "fruit_x=!random! %% 15"
set /a "fruit_y=!random! %% 15"
set /a "snake_length+=1"
)

REM Get user input for the direction
choice /c WADS /n /m "Press W (Up), A (Left), S (Down), D (Right) to move. Q to quit."

REM Update the direction based on user input
if errorlevel 4 set "direction=0"
if errorlevel 3 set "direction=1"
if errorlevel 2 set "direction=2"
if errorlevel 1 set "direction=3"
if errorlevel 5 goto :game_loop

REM End the game
endlocal


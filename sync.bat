@echo off
setlocal enabledelayedexpansion

set "SRC_GEMINI=%USERPROFILE%\.gemini"
set "DEST=%~dp0"

echo [1/3] Copying files from %SRC_GEMINI%...

:: Copy GEMINI.md
if exist "%SRC_GEMINI%\GEMINI.md" (
    copy /Y "%SRC_GEMINI%\GEMINI.md" "%DEST%GEMINI.md" >nul
    echo   + GEMINI.md
) else (
    echo   ! GEMINI.md not found
)

:: Copy mcp_config.json
if exist "%SRC_GEMINI%\config\mcp_config.json" (
    copy /Y "%SRC_GEMINI%\config\mcp_config.json" "%DEST%mcp_config.json" >nul
    echo   + mcp_config.json
) else (
    echo   ! mcp_config.json not found
)

:: Copy skills directory
if exist "%SRC_GEMINI%\config\skills" (
    if not exist "%DEST%skills" mkdir "%DEST%skills"
    robocopy "%SRC_GEMINI%\config\skills" "%DEST%skills" /E /MIR /XD .git /NFL /NDL /NJH /NJS /nc /ns /np >nul
    echo   + skills\
) else (
    echo   ! skills\ not found
)

:: Copy global_workflows directory
if exist "%SRC_GEMINI%\config\global_workflows" (
    if not exist "%DEST%global_workflows" mkdir "%DEST%global_workflows"
    robocopy "%SRC_GEMINI%\config\global_workflows" "%DEST%global_workflows" /E /MIR /XD .git /NFL /NDL /NJH /NJS /nc /ns /np >nul
    :: ensure empty dir tracked by git
    dir /b /a "%DEST%global_workflows" 2>nul | findstr "^" >nul || type nul > "%DEST%global_workflows\.gitkeep"
    echo   + global_workflows\
) else (
    echo   ! global_workflows\ not found
)

echo.
echo [2/3] Checking git diff...
cd /d "%DEST%"
git add -A

git diff --cached --quiet
if !errorlevel! equ 0 (
    echo No changes to commit.
    goto :end
)

echo.
echo Status:
git status --short
echo.
echo Diff summary:
git diff --cached --stat
echo.
git diff --cached

echo.
echo [3/3] Push to GitHub
set /p "CONFIRM=Push these changes to GitHub? (y/n): "
if /I not "!CONFIRM!"=="y" (
    echo Aborted by user. Changes staged but not committed.
    goto :end
)

set /p "MSG=Commit message (default: 'Sync agy rules, skills, and mcp'): "
if "!MSG!"=="" set "MSG=Sync agy rules, skills, and mcp"

git commit -m "!MSG!"
git branch -M main
git push -u origin main

:end
echo Done.
echo.
pause
endlocal

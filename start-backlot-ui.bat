@echo off
setlocal

rem Start the Backlot server if needed, then open the OpenMontage UI.
cd /d "%~dp0"

set "PYTHON_CMD="

if exist ".venv\Scripts\python.exe" (
    set "PYTHON_CMD=.venv\Scripts\python.exe"
) else (
    py -3 --version >nul 2>&1
    if not errorlevel 1 (
        set "PYTHON_CMD=py -3"
    ) else (
        python --version >nul 2>&1
        if not errorlevel 1 (
            set "PYTHON_CMD=python"
        )
    )
)

if not defined PYTHON_CMD (
    echo Could not find Python. Activate your environment or install Python, then run this again.
    pause
    exit /b 1
)

%PYTHON_CMD% -m backlot open %*
if errorlevel 1 (
    echo.
    echo Backlot did not start cleanly. Make sure dependencies are installed:
    echo   pip install -r requirements.txt
    echo.
    pause
    exit /b 1
)

endlocal

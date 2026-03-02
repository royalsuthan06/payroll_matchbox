@echo off
setlocal
title Matchbox ERP - Startup
cd /d "%~dp0"

:: 1. Verify Python
echo [1/4] Checking Python installation...
py --version >nul 2>&1
if %errorlevel% == 0 (set PY=py) else (set PY=python)

:: 2. Setup/Activate Environment
if not exist "venv" (
    echo [2/4] First time setup: Creating Virtual Environment...
    echo       (This may take a moment, please wait...)
    %PY% -m venv venv
) else (
    echo [2/4] Virtual Environment found. Activating...
)
call venv\Scripts\activate

:: 3. Install Requirements
echo [3/4] Checking for missing libraries (Requirements)...
echo       (This is why it usually takes a minute. Searching for updates...)
pip install -r requirements.txt --quiet
echo       Done! All libraries are ready.

:: 4. Launch Application
echo [4/4] Finalizing Startup...
echo [INFO] Starting Matchbox ERP at http://127.0.0.1:5000
echo [INFO] Please do not close this window while using the app.

:: Open browser after a 3 second delay to let the server warm up
timeout /t 3 /nobreak >nul
start "" http://127.0.0.1:5000

:: Run the app from the correct identified path
python "Payroll/app.py"

pause
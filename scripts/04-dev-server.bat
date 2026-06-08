@echo off
setlocal
cd /d "%~dp0\.."
title OTM-portfolio :: Dev Server (port 8081)
echo.
echo  -- Local dev server :: http://localhost:8081 --
echo  Ctrl+C to stop.
echo.
where python >nul 2>&1
if errorlevel 1 (
  where py >nul 2>&1
  if errorlevel 1 (
    echo  [ERROR] Python not found. Install from python.org
    exit /b 1
  )
  start "" http://localhost:8081
  py -m http.server 8081
  exit /b
)
start "" http://localhost:8081
python -m http.server 8081

@echo off
setlocal
cd /d "%~dp0\.."
title OTM-portfolio :: Fix Deps
echo.
echo  -- Reinstall netlify-cli globally --
where npm >nul 2>&1
if errorlevel 1 (
  echo  [ERROR] npm not found. Install Node.js from https://nodejs.org
  exit /b 1
)
call npm install -g netlify-cli
where netlify
netlify --version
exit /b 0

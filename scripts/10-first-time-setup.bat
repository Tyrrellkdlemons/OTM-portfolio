@echo off
setlocal
cd /d "%~dp0\.."
title OTM-portfolio :: First-Time Setup
echo.
echo  =========================================
echo   OTM-portfolio first-time setup
echo  =========================================
echo.

echo  -- Step 1: Check Git --
where git >nul 2>&1
if errorlevel 1 (
  echo  [ERROR] git not found.
  pause
  exit /b 1
)
git --version

echo.
echo  -- Step 2: Check Node + npm --
where node >nul 2>&1
if errorlevel 1 (
  echo  [WARN] node not found. Install from https://nodejs.org for CLI deploys.
) else (
  node --version
  npm --version
)

echo.
echo  -- Step 3: Init git remote --
call scripts\01-init-repo.bat

echo.
echo  -- Step 4: Install Netlify CLI --
where netlify >nul 2>&1
if errorlevel 1 (
  call npm install -g netlify-cli
) else (
  echo  netlify-cli already installed.
  netlify --version
)

echo.
echo  -- Step 5: Link to Netlify project --
echo  Run:
echo    netlify login
echo    netlify link --name otm-portfolio
echo.
echo  Then deploy with scripts\03-deploy-netlify.bat
echo.
echo  Setup complete.
exit /b 0

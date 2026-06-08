@echo off
setlocal
cd /d "%~dp0\.."
title OTM-portfolio :: Menu
:MENU
cls
echo.
echo  ============================================================
echo   OTM // PORTFOLIO  ::  ONE-CLICK MENU
echo   Project: OTM-portfolio
echo   Live:    https://otm-portfolio.netlify.app
echo   Repo:    https://github.com/Tyrrellkdlemons/OTM-portfolio
echo  ============================================================
echo.
echo   [1]  Open browser (local + live)
echo   [2]  Start local dev server (http://localhost:8081)
echo   [3]  Git status + Netlify status
echo   [4]  Commit and push to main
echo   [5]  Deploy to Netlify (production)
echo   [6]  Clean local cache
echo   [7]  Fix Netlify CLI / reinstall deps
echo   [8]  First-time setup (run this once)
echo   [9]  Initialize/repair git remote
echo.
echo   [Q]  Quit
echo.
set /p choice=  ^> Choose:
if /i "%choice%"=="1" call scripts\07-open-browser.bat & goto MENU
if /i "%choice%"=="2" call scripts\04-dev-server.bat & goto MENU
if /i "%choice%"=="3" call scripts\08-status.bat & pause & goto MENU
if /i "%choice%"=="4" call scripts\02-commit-push.bat & pause & goto MENU
if /i "%choice%"=="5" call scripts\03-deploy-netlify.bat & pause & goto MENU
if /i "%choice%"=="6" call scripts\05-clean.bat & pause & goto MENU
if /i "%choice%"=="7" call scripts\06-fix-deps.bat & pause & goto MENU
if /i "%choice%"=="8" call scripts\10-first-time-setup.bat & pause & goto MENU
if /i "%choice%"=="9" call scripts\01-init-repo.bat & pause & goto MENU
if /i "%choice%"=="Q" exit /b 0
goto MENU

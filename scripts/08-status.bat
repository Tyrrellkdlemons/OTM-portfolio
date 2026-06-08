@echo off
setlocal
cd /d "%~dp0\.."
title OTM-portfolio :: Status
echo.
echo  =========================
echo   GIT STATUS
echo  =========================
git status
echo.
echo  =========================
echo   LAST 5 COMMITS
echo  =========================
git log --oneline -5
echo.
echo  =========================
echo   REMOTES
echo  =========================
git remote -v
echo.
where netlify >nul 2>&1
if errorlevel 1 goto SKIP_NL
echo  =========================
echo   NETLIFY STATUS
echo  =========================
netlify status
:SKIP_NL
echo.
echo  Production URL: https://otmworkshops-portfolio.netlify.app
echo  Admin URL:      https://app.netlify.com/projects/otmworkshops-portfolio
exit /b 0

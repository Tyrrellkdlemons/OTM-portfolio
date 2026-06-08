@echo off
setlocal
cd /d "%~dp0\.."
title OTM-portfolio :: Commit and Push
echo.
git status --short
echo.
set /p msg=  Commit message (Enter for default):
if "%msg%"=="" set msg=Update portfolio

git add -A
git commit -m "%msg%"
if errorlevel 1 echo  Nothing to commit.

echo  ^> Pushing to origin/main
git push origin main
if errorlevel 1 (
  echo  Push failed. First push? try:
  echo    git push -u origin main
)
echo.
exit /b 0

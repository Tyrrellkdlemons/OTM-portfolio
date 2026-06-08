@echo off
setlocal
cd /d "%~dp0\.."
title OTM-portfolio :: Init Repo
echo.
echo  -- Initialize / repair git remote --
echo.

where git >nul 2>&1
if errorlevel 1 (
  echo  [ERROR] git not found. Install from https://git-scm.com
  exit /b 1
)

if not exist ".git" (
  echo  ^> git init
  git init
  git branch -M main
)

git remote -v | findstr /C:"origin" >nul 2>&1
if errorlevel 1 (
  git remote add origin https://github.com/Tyrrellkdlemons/OTM-portfolio.git
) else (
  git remote set-url origin https://github.com/Tyrrellkdlemons/OTM-portfolio.git
)

echo  ^> Current remotes:
git remote -v
echo.
echo  Done.
exit /b 0

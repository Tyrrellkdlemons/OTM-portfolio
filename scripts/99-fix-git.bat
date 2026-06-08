@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0\.."
title OTM-portfolio :: Fix Git Folder
echo.
echo  =========================================
echo   FIX CORRUPTED .git FOLDER
echo  =========================================
echo.

if not exist ".git" (
  echo  No .git folder present. Nothing to fix.
  call scripts\01-init-repo.bat
  exit /b 0
)

echo  Removing read-only attributes...
attrib -R -S -H .git\* /S /D >nul 2>&1

echo  Taking ownership (requires admin if it fails)...
takeown /F .git /R /D Y >nul 2>&1
icacls .git /grant "%USERNAME%":F /T /Q >nul 2>&1

echo  Deleting .git folder...
rmdir /S /Q .git
if exist ".git" (
  echo.
  echo  [WARN] .git still exists. Try again as Administrator,
  echo         OR delete the folder manually in File Explorer,
  echo         then re-run this script.
  pause
  exit /b 1
)

echo.
echo  .git removed. Reinitializing...
echo.
call scripts\01-init-repo.bat
echo.
echo  Done. Now run:
echo    scripts\02-commit-push.bat
echo    scripts\03-deploy-netlify.bat
exit /b 0

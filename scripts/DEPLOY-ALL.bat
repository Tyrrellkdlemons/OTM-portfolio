@echo off
setlocal
cd /d "%~dp0\.."
title OTM-portfolio :: FIRST DEPLOY (one-shot)
echo.
echo  =========================================
echo   ONE-SHOT FIRST DEPLOY
echo   1. Fix git folder if corrupted
echo   2. Init repo + add remote
echo   3. Commit and push to GitHub
echo   4. Deploy to Netlify production
echo  =========================================
echo.
echo  Pre-flight: this requires you have already
echo   - Created repo Tyrrellkdlemons/OTM-portfolio on GitHub
echo   - Linked site otmworkshops-portfolio on Netlify
echo.
pause

if exist ".git\config.lock" (
  echo  Detected lock file. Running fix...
  call scripts\99-fix-git.bat
) else if not exist ".git" (
  call scripts\01-init-repo.bat
)

call scripts\02-commit-push.bat
call scripts\03-deploy-netlify.bat

echo.
echo  Done. Open the browser launcher next:
echo    scripts\07-open-browser.bat
echo.
pause
exit /b 0

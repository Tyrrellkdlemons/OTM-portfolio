@echo off
setlocal
cd /d "%~dp0\.."
title OTM-portfolio :: Deploy to Netlify
echo.
echo  -- Deploy to Netlify (production) --
echo  Site: otmworkshops-portfolio
echo.

where netlify >nul 2>&1
if errorlevel 1 (
  echo  Netlify CLI not found. Falling back to npx.
  npx --yes netlify-cli deploy --prod --dir=. --site=otmworkshops-portfolio
  goto END
)
netlify deploy --prod --dir=. --site=otmworkshops-portfolio
:END
echo.
echo  Production URL: https://otmworkshops-portfolio.netlify.app
exit /b 0

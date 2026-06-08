@echo off
setlocal
cd /d "%~dp0\.."
title OTM-portfolio :: Clean
echo.
echo  -- Clean local caches --
echo.
if exist ".netlify\plugins" (
  echo  ^> Removing .netlify\plugins
  rmdir /S /Q ".netlify\plugins"
)
if exist "node_modules" (
  rmdir /S /Q "node_modules"
)
if exist ".cache" (
  rmdir /S /Q ".cache"
)
echo  Done.
exit /b 0

@echo off
cd /d "%~dp0"
echo Starting Fusion Plate locally...
echo.
echo Once it says "running", open http://localhost:3000 in your browser.
echo Press Ctrl+C in this window to stop the server.
echo.
node local-server.mjs
pause

@echo off
setlocal enabledelayedexpansion

:: Check for Admin privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: This script requires administrator privileges.
    echo Please right-click the script and select "Run as administrator".
    pause
    exit /b 1
)

echo Installing WinFsp...

:: Set variables
set "DOWNLOAD_URL=https://github.com/winfsp/winfsp/releases/download/v2.1/winfsp-2.1.25156.msi"
set "CACHE_DIR=%TEMP%\winfsp-install"
set "MSI_FILE=%CACHE_DIR%\winfsp-2.1.25156.msi"

:: Create cache directory
if not exist "%CACHE_DIR%" mkdir "%CACHE_DIR%"

:: Download the MSI file
echo Downloading WinFsp installer...
curl -L -o "%MSI_FILE%" "%DOWNLOAD_URL%"
if %errorlevel% neq 0 (
    echo Error: Failed to download WinFsp installer
    pause
    exit /b 1
)

:: Install silently
echo Installing WinFsp silently...
msiexec /i "%MSI_FILE%" /quiet /norestart
if %errorlevel% neq 0 (
    rmdir /s /q "%CACHE_DIR%"
    echo Error: Failed to install WinFsp
    pause
    exit /b 1
)

:: Clean up
echo Cleaning up temporary files...
rmdir /s /q "%CACHE_DIR%"

echo WinFsp installation completed successfully!
echo You can now run win-ifuse.exe - Checkout repo (https://github.com/uncor3/win-ifuse) for examples.
pause
exit /b 0
@echo off
setlocal enabledelayedexpansion

net session >nul 2>&1
if %errorlevel% neq 0 (
    exit /b 1
)

echo Installing WinFsp...

set "DOWNLOAD_URL=https://github.com/winfsp/winfsp/releases/download/v2.1/winfsp-2.1.25156.msi"
set "CACHE_DIR=%TEMP%\winfsp-install"
set "MSI_FILE=%CACHE_DIR%\winfsp-2.1.25156.msi"

if not exist "%CACHE_DIR%" mkdir "%CACHE_DIR%"

curl -L -o "%MSI_FILE%" "%DOWNLOAD_URL%"
if %errorlevel% neq 0 (
    exit /b 1
)

msiexec /i "%MSI_FILE%" /quiet /norestart
if %errorlevel% neq 0 (
    rmdir /s /q "%CACHE_DIR%"
    exit /b 1
)

rmdir /s /q "%CACHE_DIR%"
exit /b 0
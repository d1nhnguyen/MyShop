@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo Testing database setup...
echo.

:: Detect Docker
set "USE_DOCKER=0"
set "DOCKER_CONTAINER="

docker ps --filter "name=postgres" --format "{{.Names}}" 2>nul | findstr "postgres" >nul
if %errorLevel% equ 0 (
    echo [OK] Found Docker PostgreSQL
    for /f "tokens=*" %%i in ('docker ps --filter "name=postgres" --format "{{.Names}}"') do (
        set "DOCKER_CONTAINER=%%i"
        goto :found
    )
    :found
    set "USE_DOCKER=1"
    echo Container: !DOCKER_CONTAINER!
) else (
    echo [INFO] No Docker PostgreSQL found
)

echo.
echo Testing connection...
if "%USE_DOCKER%"=="1" (
    docker exec %DOCKER_CONTAINER% psql -U admin -d postgres -c "SELECT version();"
) else (
    echo No Docker container to test
)

pause

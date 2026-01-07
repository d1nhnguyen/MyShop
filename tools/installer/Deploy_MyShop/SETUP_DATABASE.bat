@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Chuyển đến thư mục chứa script
cd /d "%~dp0"

:: ═══════════════════════════════════════════════════════════════════════════════
:: MYSHOP DATABASE SETUP SCRIPT
:: Tự động tạo database và import dữ liệu
:: ═══════════════════════════════════════════════════════════════════════════════
title MyShop - Database Setup
echo.
echo ╔══════════════════════════════════════════════════════════════════════════════╗
echo ║                  MYSHOP DATABASE SETUP WIZARD                                ║
echo ║                         Phiên bản 1.0                                        ║
echo ╚══════════════════════════════════════════════════════════════════════════════╝
echo.
:: Kiểm tra quyền Administrator
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Script này cần quyền Administrator!
    echo Vui lòng chuột phải và chọn "Run as Administrator"
    pause
    exit /b 1
)
:: ═══════════════════════════════════════════════════════════════════════════════
:: BƯỚC 1: Kiểm tra PostgreSQL
:: ═══════════════════════════════════════════════════════════════════════════════

echo [1/6] Đang kiểm tra PostgreSQL...
echo.

:: Kiểm tra Docker PostgreSQL trước
set "USE_DOCKER=0"
set "DOCKER_CONTAINER="
set "PSQL_CMD="

docker ps --filter "name=postgres" --format "{{.Names}}" 2>nul | findstr "postgres" >nul
if %errorLevel% equ 0 (
    echo [INFO] Phát hiện PostgreSQL đang chạy trong Docker!
    echo.
    
    :: Lấy tên container
    for /f "tokens=*" %%i in ('docker ps --filter "name=postgres" --format "{{.Names}}"') do (
        set "DOCKER_CONTAINER=%%i"
        goto :found_docker_container_name
    )
    
    :found_docker_container_name
    echo [OK] Sử dụng Docker container: !DOCKER_CONTAINER!
    set "USE_DOCKER=1"
    set "PSQL_CMD=docker exec !DOCKER_CONTAINER! psql"
    echo.
    goto :docker_setup
)

:: Nếu không có Docker, tìm PostgreSQL cài đặt trực tiếp
echo [INFO] Không tìm thấy Docker PostgreSQL, đang tìm PostgreSQL cài đặt...
echo.

set "PSQL_PATH="
set "PGDUMP_PATH="

for %%P in (
    "C:\Program Files\PostgreSQL\15\bin\psql.exe"
    "C:\Program Files\PostgreSQL\16\bin\psql.exe"
    "C:\Program Files\PostgreSQL\17\bin\psql.exe"
    "C:\Program Files\PostgreSQL\14\bin\psql.exe"
    "C:\Program Files (x86)\PostgreSQL\15\bin\psql.exe"
    "C:\Program Files (x86)\PostgreSQL\16\bin\psql.exe"
) do (
    if exist %%P (
        set "PSQL_PATH=%%~P"
        set "PGDUMP_PATH=%%~dpPpg_dump.exe"
        goto :found_psql_native
    )
)

:found_psql_native
if not defined PSQL_PATH (
    echo [ERROR] Không tìm thấy PostgreSQL!
    echo.
    echo Vui lòng cài đặt PostgreSQL từ:
    echo https://www.postgresql.org/download/windows/
    echo.
    echo HOẶC sử dụng Docker:
    echo docker run --name myshop_postgres -e POSTGRES_PASSWORD=admin -p 5432:5432 -d postgres:15
    echo.
    pause
    exit /b 1
)

echo [OK] Tìm thấy PostgreSQL: %PSQL_PATH%
set "PSQL_CMD=%PSQL_PATH%"
echo.

:docker_setup
:: ═══════════════════════════════════════════════════════════════════════════════
:: BƯỚC 2: Nhập thông tin kết nối
:: ═══════════════════════════════════════════════════════════════════════════════
echo [2/6] Cấu hình kết nối database...
echo.
set /p "DB_USER=Nhập tên user PostgreSQL (mặc định: postgres): "
if "%DB_USER%"=="" set "DB_USER=postgres"
set /p "DB_PASS=Nhập mật khẩu PostgreSQL (mặc định: admin): "
if "%DB_PASS%"=="" set "DB_PASS=admin"
set /p "DB_HOST=Nhập địa chỉ server (mặc định: localhost): "
if "%DB_HOST%"=="" set "DB_HOST=localhost"
set /p "DB_PORT=Nhập port (mặc định: 5432): "
if "%DB_PORT%"=="" set "DB_PORT=5432"
set "DB_NAME=myshop"
echo.
echo Thông tin kết nối:
echo   User: %DB_USER%
echo   Host: %DB_HOST%
echo   Port: %DB_PORT%
echo   Database: %DB_NAME%
echo.
set PGPASSWORD=%DB_PASS%
:: ═══════════════════════════════════════════════════════════════════════════════
:: BƯỚC 3: Kiểm tra kết nối
:: ═══════════════════════════════════════════════════════════════════════════════

echo [3/6] Kiểm tra kết nối đến PostgreSQL...
echo.

if "%USE_DOCKER%"=="1" (
    docker exec %DOCKER_CONTAINER% psql -U %DB_USER% -d postgres -c "SELECT version();" >nul 2>&1
) else (
    set PGPASSWORD=%DB_PASS%
    "%PSQL_CMD%" -U %DB_USER% -h %DB_HOST% -p %DB_PORT% -d postgres -c "SELECT version();" >nul 2>&1
)

if %errorLevel% neq 0 (
    echo [ERROR] Không thể kết nối đến PostgreSQL!
    echo.
    echo Vui lòng kiểm tra:
    echo   - PostgreSQL đã chạy chưa
    echo   - Tên user và mật khẩu có đúng không
    echo   - Port có đúng không
    echo.
    pause
    exit /b 1
)

echo [OK] Kết nối thành công!
echo.
:: ═══════════════════════════════════════════════════════════════════════════════
:: BƯỚC 4: Tạo database
:: ═══════════════════════════════════════════════════════════════════════════════
echo [4/6] Tạo database "%DB_NAME%"...
echo.
:: Kiểm tra database đã tồn tại chưa
if "%USE_DOCKER%"=="1" (
    docker exec %DOCKER_CONTAINER% psql -U %DB_USER% -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='%DB_NAME%'" | findstr "1" >nul
) else (
    "%PSQL_CMD%" -U %DB_USER% -h %DB_HOST% -p %DB_PORT% -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='%DB_NAME%'" | findstr "1" >nul
)
if %errorLevel% equ 0 (
    echo [WARNING] Database "%DB_NAME%" đã tồn tại!
    echo.
    set /p "CONFIRM=Bạn có muốn XÓA và tạo lại database? (y/N): "
    if /i not "!CONFIRM!"=="y" (
        echo.
        echo [INFO] Giữ nguyên database hiện tại và tiếp tục import...
        goto :import_data
    )
    
    echo [INFO] Đang ngắt kết nối đến database...
    if "%USE_DOCKER%"=="1" (
        docker exec %DOCKER_CONTAINER% psql -U %DB_USER% -d postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='%DB_NAME%' AND pid <> pg_backend_pid();" >nul 2>&1
    ) else (
        "%PSQL_CMD%" -U %DB_USER% -h %DB_HOST% -p %DB_PORT% -d postgres -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname='%DB_NAME%' AND pid <> pg_backend_pid();" >nul 2>&1
    )
    
    echo [INFO] Đang xóa database cũ...
    if "%USE_DOCKER%"=="1" (
        docker exec %DOCKER_CONTAINER% psql -U %DB_USER% -d postgres -c "DROP DATABASE IF EXISTS %DB_NAME%;" >nul 2>&1
    ) else (
        "%PSQL_CMD%" -U %DB_USER% -h %DB_HOST% -p %DB_PORT% -d postgres -c "DROP DATABASE IF EXISTS %DB_NAME%;" >nul 2>&1
    )
    
    if !errorLevel! neq 0 (
        echo [ERROR] Không thể xóa database!
        echo Có thể database đang được sử dụng.
        pause
        exit /b 1
    )
)

echo [INFO] Đang tạo database mới...
if "%USE_DOCKER%"=="1" (
    docker exec %DOCKER_CONTAINER% psql -U %DB_USER% -d postgres -c "CREATE DATABASE %DB_NAME% OWNER %DB_USER%;" >nul 2>&1
) else (
    "%PSQL_CMD%" -U %DB_USER% -h %DB_HOST% -p %DB_PORT% -d postgres -c "CREATE DATABASE %DB_NAME% OWNER %DB_USER%;" >nul 2>&1
)
if %errorLevel% neq 0 (
    echo [ERROR] Không thể tạo database!
    pause
    exit /b 1
)
echo [OK] Database "%DB_NAME%" đã được tạo!
echo.
:: ═══════════════════════════════════════════════════════════════════════════════
:: BƯỚC 5: Import dữ liệu
:: ═══════════════════════════════════════════════════════════════════════════════
:import_data
echo [5/6] Import dữ liệu từ Database.sql...
echo.
if not exist "Database.sql" (
    echo [ERROR] Không tìm thấy file Database.sql!
    echo Vui lòng đảm bảo file Database.sql nằm cùng thư mục với script này.
    pause
    exit /b 1
)
echo [INFO] Đang import... (có thể mất vài phút)
echo.
if "%USE_DOCKER%"=="1" (
    :: Copy file vào container và import
    docker cp "Database.sql" %DOCKER_CONTAINER%:/tmp/Database.sql >nul 2>&1
    docker exec %DOCKER_CONTAINER% psql -U %DB_USER% -d %DB_NAME% -f /tmp/Database.sql >nul 2>&1
) else (
    "%PSQL_CMD%" -U %DB_USER% -h %DB_HOST% -p %DB_PORT% -d %DB_NAME% -f "Database.sql" >nul 2>&1
)
if %errorLevel% neq 0 (
    echo [ERROR] Import dữ liệu thất bại!
    echo.
    echo Vui lòng kiểm tra:
    echo   - File Database.sql có hợp lệ không
    echo   - User có quyền tạo bảng không
    echo.
    pause
    exit /b 1
)
echo [OK] Import dữ liệu thành công!
echo.
:: ═══════════════════════════════════════════════════════════════════════════════
:: BƯỚC 6: Cập nhật file .env
:: ═══════════════════════════════════════════════════════════════════════════════
echo [6/6] Cập nhật file cấu hình .env...
echo.
if exist "Backend_Deploy\.env" (
    set "ENV_FILE=Backend_Deploy\.env"
) else if exist ".env" (
    set "ENV_FILE=.env"
) else (
    echo [WARNING] Không tìm thấy file .env
    echo Bạn cần tự tạo file .env với nội dung:
    echo.
    echo DATABASE_URL="postgresql://%DB_USER%:%DB_PASS%@%DB_HOST%:%DB_PORT%/%DB_NAME%?schema=public"
    echo.
    goto :success
)
:: Backup file .env cũ
if exist "%ENV_FILE%.backup" del "%ENV_FILE%.backup"
copy "%ENV_FILE%" "%ENV_FILE%.backup" >nul 2>&1
:: Cập nhật DATABASE_URL
set "NEW_DB_URL=postgresql://%DB_USER%:%DB_PASS%@%DB_HOST%:%DB_PORT%/%DB_NAME%?schema=public"
powershell -Command "(Get-Content '%ENV_FILE%') -replace 'DATABASE_URL=.*', 'DATABASE_URL=\"%NEW_DB_URL%\"' | Set-Content '%ENV_FILE%'" >nul 2>&1
echo [OK] File .env đã được cập nhật!
echo     DATABASE_URL="%NEW_DB_URL%"
echo.
:: ═══════════════════════════════════════════════════════════════════════════════
:: HOÀN THÀNH
:: ═══════════════════════════════════════════════════════════════════════════════
:success
echo.
echo ╔══════════════════════════════════════════════════════════════════════════════╗
echo ║                          CÀI ĐẶT THÀNH CÔNG! ✓                               ║
echo ╚══════════════════════════════════════════════════════════════════════════════╝
echo.
echo Database đã được setup với thông tin sau:
echo.
echo   ✓ Database: %DB_NAME%
echo   ✓ User: %DB_USER%
echo   ✓ Host: %DB_HOST%:%DB_PORT%
echo   ✓ Dữ liệu: Đã import thành công
echo.
echo Tài khoản đăng nhập mặc định:
echo.
echo   ┌─────────────────────────────────┐
echo   │ ADMIN:                          │
echo   │ Username: admin                 │
echo   │ Password: Admin@123456          │
echo   │                                 │
echo   │                                 │
echo   │ STAFF:                          │
echo   │ Username: staff1                │
echo   │ Password: Password@123          │
echo   └─────────────────────────────────┘
echo.
echo License Key mẫu: MYSHOP-TRIAL-0001
echo.
echo Bây giờ bạn có thể chạy ứng dụng MyShop Management!
echo.
pause
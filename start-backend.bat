@echo off
echo Starting SenioCareX Backend Server...
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Node.js is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

REM Check if we're in the right directory
if not exist "backend\package.json" (
    echo Error: backend\package.json not found
    echo Please run this script from the project root directory
    pause
    exit /b 1
)

REM Navigate to backend directory
cd backend

REM Check if dependencies are installed
if not exist "node_modules" (
    echo Installing dependencies...
    npm install
    if %errorlevel% neq 0 (
        echo Error: Failed to install dependencies
        pause
        exit /b 1
    )
)

REM Check if .env file exists
if not exist ".env" (
    echo Creating .env file from template...
    copy .env.example .env
    echo.
    echo IMPORTANT: Please edit the .env file with your configuration:
    echo - Set your MongoDB connection string
    echo - Configure email settings
    echo - Set JWT secrets
    echo.
    echo Press any key to continue after editing .env file...
    pause
)

REM Start the server
echo Starting server...
echo.
echo Backend server will be available at: http://localhost:5000
echo Health check: http://localhost:5000/health
echo API documentation: http://localhost:5000/api
echo.
echo Press Ctrl+C to stop the server
echo.

npm run dev
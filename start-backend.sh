#!/bin/bash

echo "Starting SenioCareX Backend Server..."
echo

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "Error: Node.js is not installed"
    echo "Please install Node.js from https://nodejs.org/"
    exit 1
fi

# Check if we're in the right directory
if [ ! -f "backend/package.json" ]; then
    echo "Error: backend/package.json not found"
    echo "Please run this script from the project root directory"
    exit 1
fi

# Navigate to backend directory
cd backend

# Check if dependencies are installed
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install dependencies"
        exit 1
    fi
fi

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo "Creating .env file from template..."
    cp .env.example .env
    echo
    echo "IMPORTANT: Please edit the .env file with your configuration:"
    echo "- Set your MongoDB connection string"
    echo "- Configure email settings"
    echo "- Set JWT secrets"
    echo
    echo "Press any key to continue after editing .env file..."
    read -n 1 -s
fi

# Start the server
echo "Starting server..."
echo
echo "Backend server will be available at: http://localhost:5000"
echo "Health check: http://localhost:5000/health"
echo "API documentation: http://localhost:5000/api"
echo
echo "Press Ctrl+C to stop the server"
echo

npm run dev
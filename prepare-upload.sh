#!/bin/bash

echo "========================================"
echo "Preparing Files for Server Upload"
echo "========================================"
echo ""

# Remove old upload folder if exists
if [ -d "upload-to-server" ]; then
    echo "Removing old upload folder..."
    rm -rf "upload-to-server"
fi

# Build the project first
echo "Step 1: Building project..."
echo ""

if command -v pnpm &> /dev/null; then
    echo "Using pnpm..."
    pnpm install
    pnpm run build
elif command -v npm &> /dev/null; then
    echo "Using npm..."
    npm install
    npm run build
else
    echo "ERROR: pnpm or npm not found!"
    echo "Please install Node.js from https://nodejs.org"
    exit 1
fi

if [ $? -ne 0 ]; then
    echo ""
    echo "ERROR: Build failed! Please check the errors above."
    exit 1
fi

echo ""
echo "Step 2: Creating upload folder..."
mkdir -p "upload-to-server"

echo "Step 3: Copying files to upload folder..."

# Copy all files from dist to upload-to-server
cp -r dist/* upload-to-server/

echo ""
echo "========================================"
echo "✓ Files ready for upload!"
echo "========================================"
echo ""
echo "Upload folder created: upload-to-server"
echo ""
echo "Upload these files to your Hostinger server:"
echo "  - Go to Hostinger File Manager"
echo "  - Navigate to public_html folder"
echo "  - Upload ALL files from 'upload-to-server' folder"
echo ""

# Open folder (macOS/Linux)
if [[ "$OSTYPE" == "darwin"* ]]; then
    open "upload-to-server"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open "upload-to-server" 2>/dev/null || echo "Upload folder is ready at: upload-to-server"
fi


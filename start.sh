#!/bin/bash

# NINJABR.CLOUD Start Script
# This script starts both the Go backend and the Vue frontend.

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${ORANGE}=======================================${NC}"
echo -e "${ORANGE}     STARTING NINJABR.CLOUD           ${NC}"
echo -e "${ORANGE}=======================================${NC}"

# Function to kill background processes on exit
cleanup() {
    echo -e "\n${BLUE}Stopping services...${NC}"
    kill $BACKEND_PID $FRONTEND_PID 2>/dev/null
    exit
}

trap cleanup SIGINT SIGTERM

# 1. Start Backend (Go)
echo -e "${BLUE}[1/2] Starting Backend (Go)...${NC}"
cd server
if [ ! -f "./neko" ]; then
    echo -e "${ORANGE}Backend binary not found. Building...${NC}"
    go build -o neko ./neko.go
fi
./neko & 
BACKEND_PID=$!
cd ..

# 2. Start Frontend (Vue)
echo -e "${BLUE}[2/2] Starting Frontend (Node)...${NC}"
cd client
# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo -e "${ORANGE}Node modules not found. Installing...${NC}"
    npm install
fi
npm run serve &
FRONTEND_PID=$!
cd ..

echo -e "${GREEN}Both services are starting!${NC}"
echo -e "${GREEN}Backend PID: $BACKEND_PID${NC}"
echo -e "${GREEN}Frontend PID: $FRONTEND_PID${NC}"
echo -e "${BLUE}Press Ctrl+C to stop both.${NC}"

# Keep script running to maintain background processes
wait

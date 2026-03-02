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
    kill $FRONTEND_PID 2>/dev/null
    $DOCKER_CMD stop neko-backend > /dev/null 2>&1
    exit
}

trap cleanup SIGINT SIGTERM

# Detect if docker needs sudo
DOCKER_CMD="docker"
if ! docker ps > /dev/null 2>&1; then
    if sudo -n docker ps > /dev/null 2>&1; then
        DOCKER_CMD="sudo docker"
    else
        echo -e "${ORANGE}Warning: Docker might need sudo. If it fails, try running 'sudo usermod -aG docker $USER' and restart your session.${NC}"
        DOCKER_CMD="sudo docker"
    fi
fi

# 1. Start Backend (Docker)
echo -e "${BLUE}[1/2] Starting Backend (Docker)...${NC}"
# Check if a container named neko-backend is already running
if [ "$($DOCKER_CMD ps -q -f name=neko-backend)" ]; then
    echo -e "${ORANGE}Stopping existing neko-backend container...${NC}"
    $DOCKER_CMD stop neko-backend > /dev/null
fi
if [ "$($DOCKER_CMD ps -aq -f name=neko-backend)" ]; then
    echo -e "${ORANGE}Removing existing neko-backend container...${NC}"
    $DOCKER_CMD rm neko-backend > /dev/null
fi

echo -e "${ORANGE}Starting official Neko backend image...${NC}"
$DOCKER_CMD run -d \
    --name neko-backend \
    -p 8080:8080 \
    -p 52000-52100:52000-52100/udp \
    --shm-size=2gb \
    -e NEKO_MEMBER_MULTIUSER_USER_PASSWORD=neko \
    -e NEKO_MEMBER_MULTIUSER_ADMIN_PASSWORD=admin \
    ghcr.io/m1k1o/neko/firefox:latest > /dev/null

# Detect if running as root via sudo
NPM_CMD="npm"
if [ -n "$SUDO_USER" ] && [ "$SUDO_USER" != "root" ]; then
    # If running with sudo, we need to run npm as the original user
    # to find node/npm in their PATH (e.g. if using nvm)
    NPM_CMD="sudo -u $SUDO_USER -i npm"
fi

# 2. Start Frontend (Node)
echo -e "${BLUE}[2/2] Starting Frontend (Node)...${NC}"
cd client
if [ ! -d "node_modules" ]; then
    echo -e "${ORANGE}Node modules not found. Installing...${NC}"
    $NPM_CMD install
fi
# Run frontend on 8081 and point it to backend on 8080
PORT=8081 VUE_APP_SERVER_PORT=8080 $NPM_CMD run serve &
FRONTEND_PID=$!
cd ..

echo -e "${GREEN}Both services are starting!${NC}"
echo -e "${GREEN}Frontend PID: $FRONTEND_PID${NC}"
echo -e "${BLUE}Press Ctrl+C to stop both.${NC}"

# Keep script running to maintain background processes
wait

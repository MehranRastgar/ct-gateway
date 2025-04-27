#!/bin/bash

# رنگ‌های ترمینال
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting build and run process...${NC}"

# ساخت تصاویر Docker
echo -e "${GREEN}Building Docker images...${NC}"

# ساخت تصویر Identity Service
echo -e "${YELLOW}Building Identity Service...${NC}"
cd ../IdentityService
docker build -t identity-service:latest .

# ساخت تصویر Workout Service
echo -e "${YELLOW}Building Workout Service...${NC}"
cd ../WorkoutService
docker build -t workout-service:latest .

# برگشت به پوشه Gateway
cd ../gateway

# اجرای سرویس‌ها با Docker Compose
echo -e "${GREEN}Running services with Docker Compose...${NC}"
docker-compose up -d

echo -e "${GREEN}Services are running!${NC}"
echo -e "${YELLOW}Gateway: http://localhost:7001${NC}"
echo -e "${YELLOW}Identity Service: http://localhost:7132${NC}"
echo -e "${YELLOW}Workout Service: http://localhost:5084${NC}"

# نمایش لاگ‌ها
echo -e "${GREEN}Showing logs...${NC}"
docker-compose logs -f 
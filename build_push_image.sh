#!/bin/bash

# Redirect all output (stdout and stderr) to log.txt
if [ -f log.txt ]; then
    rm log.txt
fi
exec > >(tee -a log.txt) 2>&1

# Load environment variables from .env file
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
else
    echo "Warning: .env file not found"
fi

# Build Docker image from Dockerfile
# -t flag tags the image as 'item-app:v1'
docker build -t item-app:v1 .

# List all Docker images to verify the build
docker images

# Tag the image for GitHub Packages (Container Registry)
docker tag item-app:v1 ghcr.io/$GITHUB_USERNAME/item-app:v1

# Login to GitHub Packages using credentials from .env
echo $GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_USERNAME --password-stdin

# Push the image to GitHub Packages
docker push ghcr.io/$GITHUB_USERNAME/item-app:v1

# Start the application using docker-compose with sudo and password from .env
echo $SUDO_PASSWORD | sudo -S docker-compose up

# Wait for 5 minutes (300 seconds)
sleep 300

# Stop and remove the containers using docker-compose
echo $SUDO_PASSWORD | sudo -S docker-compose down
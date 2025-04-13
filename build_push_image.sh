#!/bin/bash

# Build Docker image from Dockerfile
# -t flag tags the image as 'item-app:v1'
docker build -t item-app:v1 .

# List all Docker images to verify the build
docker images

# Tag the image for GitHub Packages (Container Registry)
# Replace 'carlgeralz' with your GitHub username
docker tag item-app:v1 carlgeralz/item-app:v1

# Login to GitHub Packages
# You'll need a GitHub personal access token with appropriate permissions
echo $GITHUB_TOKEN | docker login carlgeralz --password-stdin

# Push the image to GitHub Packages
docker push carlgeralz/item-app:v1
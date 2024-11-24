#!/bin/bash
set -e

# Update and upgrade system
echo "Updating and upgrading the system..."
apt-get update && apt-get upgrade -y

# Install Docker and Git
echo "Installing Docker and Git..."
apt-get install -y docker.io git

# Add Docker to startup and ensure it is running
systemctl start docker
systemctl enable docker

# Add 'azureuser' to the Docker group
echo "Adding 'azureuser' to the Docker group..."
usermod -aG docker azureuser

# Install OpenJDK 11 (required for Jenkins)
echo "Installing OpenJDK 11..."
apt-get install -y openjdk-11-jdk

# Install Jenkins in Docker
echo "Pulling Jenkins image from Docker Hub..."
docker pull jenkins/jenkins:lts

# Create Docker volume for Jenkins data
echo "Creating Docker volume for Jenkins data..."
docker volume create jenkins_home

# Run Jenkins container
echo "Running Jenkins in Docker..."
docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/jenkins:lts

# Ensure 'azureuser' can manage Jenkins
echo "Granting 'azureuser' permissions to manage Docker and Jenkins..."
chown azureuser:docker /var/run/docker.sock

echo "Installation complete! Access Jenkins at http://<your_vm_ip>:8080"

#!/bin/bash

set -e  # Exit on error

# Log all output
exec > >(tee -a /var/log/user-data.log) 2>&1

echo "Starting Ubuntu EC2 setup..."

# Update package list
apt-get update -y

# Install Apache2
echo "Installing Apache2..."
apt-get install -y apache2

# Enable Apache to start on boot
systemctl enable apache2

# Start Apache service
systemctl start apache2

# Check Apache status
echo "Apache2 status:"
systemctl status apache2 --no-pager

# Install AWS CLI v2
echo "Installing AWS CLI v2..."
apt-get install -y curl unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf awscliv2.zip aws/

# Verify AWS CLI installation
echo "AWS CLI version:"
aws --version

# Install Docker
echo "Installing Docker..."
apt-get install -y ca-certificates gnupg lsb-release

# Add Docker's official GPG key
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Set up Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list with Docker repo
apt-get update -y

# Install Docker Engine
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Enable Docker to start on boot
systemctl enable docker

# Start Docker service
systemctl start docker

# Add ubuntu user to docker group (optional, for non-root docker usage)
usermod -aG docker ubuntu

# Verify Docker installation
echo "Docker version:"
docker --version

echo "Setup completed successfully!"
echo "Services status:"
echo "Apache2: $(systemctl is-active apache2)"
echo "Docker: $(systemctl is-active docker)"
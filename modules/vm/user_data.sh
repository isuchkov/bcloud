#!/bin/bash
set -e
apt-get update && apt-get upgrade -y
apt-get install -y docker.io git
apt-get install -y openjdk-11-jdk
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | tee /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update
apt-get install -y jenkins
systemctl start jenkins
systemctl enable jenkins
echo "Installation complete!"
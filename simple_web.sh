#!/bin/bash

# Update package lists
sudo apt update -y

# Install Nginx
sudo apt install -y nginx

# Start and enable Nginx service
sudo systemctl start nginx
sudo systemctl enable nginx

# Set up a basic web page
echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html

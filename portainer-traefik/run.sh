#!/bin/bash

# Check if portainer.yourdomain.com exists in docker-compose.yml and ask for replacement 
if grep -q "portainer.yourdomain.com" docker-compose.yml; then
    read -p "Enter the new Portainer admin URL (portainer.yourdomain.com): " admin_url
    sed -i "s|portainer.yourdomain.com|${admin_url}|g" docker-compose.yml
    echo "New Portainer admin URL has been set up."
else
    echo "No need to replace Portainer admin URL."
fi

# Check if admin@yourdomain.com exists in docker-compose.yml and ask for replacement
if grep -q "admin@yourdomain.com" docker-compose.yml; then
    read -p "Enter the new admin email for LetsEncrypt: " admin_email
    sed -i "s|admin@yourdomain.com|${admin_email}|g" docker-compose.yml
    echo "New admin email has been set up."
else
    echo "No need to replace admin email."
fi

# Initialize Docker Swarm
docker swarm init

# Create the traefik_public Docker network
docker network create --driver overlay --attachable traefik_public

# Start the services in detached mode
docker stack deploy -c docker-compose.yml portainer

echo "Portainer and Traefik have been started in Docker Swarm mode."

#!/bin/bash

# Check if portainer.yourdomain.com exists in protainer-traefik-stack.yml and ask for replacement 
if grep -q "portainer.yourdomain.com" protainer-traefik-stack.yml; then
    read -p "Enter the new Portainer admin URL (portainer.yourdomain.com): " admin_url
    sed -i "s|portainer.yourdomain.com|${admin_url}|g" protainer-traefik-stack.yml
    echo "New Portainer admin URL has been set up."
else
    echo "No need to replace Portainer admin URL."
fi

# Check if admin@yourdomain.com exists in protainer-traefik-stack.yml and ask for replacement
if grep -q "admin@yourdomain.com" protainer-traefik-stack.yml; then
    read -p "Enter the new admin email for LetsEncrypt: " admin_email
    sed -i "s|admin@yourdomain.com|${admin_email}|g" protainer-traefik-stack.yml
    echo "New admin email has been set up."
else
    echo "No need to replace admin email."
fi

# Initialize Docker Swarm
docker swarm init

# Create the traefik_public Docker network
docker network create --driver overlay --attachable traefik_public

# Start the services in detached mode
docker stack deploy -c protainer-traefik-stack.yml portainer

echo "Portainer and Traefik have been started in Docker Swarm mode."

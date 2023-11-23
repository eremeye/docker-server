#!/bin/bash

# Create an error trap
handle_error() {
  echo "Docker setup was aborted. Reason: $1 failed with exit code $?."
}

trap 'handle_error $BASH_COMMAND' ERR

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

# Get all available network interfaces
NET_INTERFACES=$(ls /sys/class/net)

echo "Available network interfaces:"
for INTERFACE in $NET_INTERFACES; do
    IP_ADDRESS=$(ip -4 addr show $INTERFACE | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    echo "$INTERFACE - IP Address: $IP_ADDRESS"
done

read -p "Choose the network interface from the list above (e.g., eth0): " chosen_interface

# Get the primary IP address for the chosen network interface
IP_ADDRESS=$(ip -4 addr show $chosen_interface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

# Initialize Docker Swarm with the specified advertise address
docker swarm init --advertise-addr $IP_ADDRESS

# Create the traefik_public Docker network
docker network create --driver=overlay --attachable traefik_public

# Start the services in detached mode
docker stack deploy -c protainer-traefik-stack.yml portainer

echo "Portainer and Traefik have been started in Docker Swarm mode."
exit 0

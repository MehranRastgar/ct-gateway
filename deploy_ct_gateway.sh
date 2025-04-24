#!/bin/bash

# Define variables
IMAGE_TAG="v1"
IMAGE_NAME="ct-gateway:$IMAGE_TAG"
CONTAINER_NAME="ct-gateway"
HOST_PORT=7001
CONTAINER_PORT=7001
UPLOADS_VOLUME="uploads_volume"

# Build the Docker image
docker build --build-arg BUILD_CONFIGURATION=Release -t $IMAGE_NAME .

# Stop and remove any existing container with the same name
docker stop $CONTAINER_NAME || true
docker rm $CONTAINER_NAME || true

# Run the container with specified settings
docker run -d --name $CONTAINER_NAME \
  -p $HOST_PORT:$CONTAINER_PORT \
  -v $UPLOADS_VOLUME:/app/wwwroot/uploads \
  $IMAGE_NAME

# Create and connect networks
NETWORKS=("gateway" "redis" "sql-server")

for NETWORK in "${NETWORKS[@]}"; do
  docker network create --driver bridge $NETWORK || true
  docker network connect $NETWORK $CONTAINER_NAME
done
docker network connect gw ct-gateway



echo "Deployment of $CONTAINER_NAME completed successfully."

# Make the script executable and run it:
# chmod +x deploy_ct_gateway.sh
# ./deploy_ct_gateway.sh

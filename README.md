# CT Gateway Service

API Gateway service for the CT Communication platform. This service routes requests to appropriate microservices using Ocelot.

## Features

- Routes API requests to appropriate microservices
- Handles authentication and authorization
- Manages service discovery
- Provides unified endpoint for client applications

## Prerequisites

- Docker
- .NET 7.0 or later

## Configuration

The gateway routes are configured in `ocelot.json`. The following services are currently supported:

- Identity Service (Authentication & User Management)
- Post Service (Social Posts & Images)
- Book Services (Upload & Translation)
- TTS Service (Text-to-Speech)
- Product Service

## Docker Setup

### Build the Image

```bash
# Build with Release configuration
docker build --build-arg BUILD_CONFIGURATION=Release -t ct-gateway:latest .

# Build with Debug configuration
docker build --build-arg BUILD_CONFIGURATION=Debug -t ct-gateway:latest .
```

### Network Setup

```bash
# Create network if it doesn't exist
docker network create gw

# Connect services to network
docker network connect gw ct-gateway
docker network connect gw identity-service
```

### Run Container

```bash
# Run the gateway service
docker run -d --name ct-gateway --network gw -p 7001:7001 ct-gateway

# Run with immediate rebuild
docker run -d --name ct-gateway --network gw -p 7001:7001 ct-gateway --build
```

### Maintenance Commands

```bash
# Stop the container
docker stop ct-gateway

# Remove the container
docker rm ct-gateway
```

## API Documentation

The gateway serves as a reverse proxy and routes requests to the following base endpoints:

- `/api/auth/*` - Authentication endpoints
- `/api/user/*` - User management
- `/api/post/*` - Social posts and interactions
- `/api/books/*` - Book management
- `/api/translation/*` - Book translation
- `/api/tts/*` - Text-to-speech
- `/api/product/*` - Product management

For detailed API documentation, please refer to individual service documentation.

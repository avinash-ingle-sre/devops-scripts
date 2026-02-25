#!/bin/bash
check_dockerfile_security() {
    local dockerfile="$1"
    echo "Scanning Dockerfile for security issues..."
    
    # Check for root user
    if grep -q "USER root" "$dockerfile"; then
        echo "  ⚠️ HIGH: Container running as root"
    fi
    
    # Check for outdated base images
    if grep -q "ubuntu:16.04\|ubuntu:18.04" "$dockerfile"; then
        echo "  🚨 CRITICAL: Outdated base image with known vulnerabilities"
    fi
    
    # Check for secrets in container
    if grep -q "COPY.*\.key\|COPY.*\.pem" "$dockerfile"; then
        echo "  ⚠️ MEDIUM: Private keys copied to container"
    fi
}

# Create insecure Dockerfile
cat > Dockerfile << 'DOCKER'
FROM ubuntu:16.04
USER root

RUN apt-get update && apt-get install -y curl

COPY secrets.key /app/
COPY database.pem /app/

WORKDIR /app
CMD ["python", "app.py"]
DOCKER

check_dockerfile_security "Dockerfile"

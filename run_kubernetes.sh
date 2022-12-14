#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
# dockerpath=<>
dockerpath=dockerkayse/microservices-api
# Step 2
# Run the Docker Hub container with kubernetes
kubectl run microservices-api  --image=$dockerpath:latest --port=80

# Step 3:
# List kubernetes pods
kubectl get pods
# Step 4:
# Forward the container port to a host
kubectl port-forward microservices-api --address 0.0.0.0 8000:80

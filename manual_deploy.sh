#!/bin/sh
# For local testing - deploy the docker image manually

aws ecr get-login-password --region us-east-1 --profile udacityfed | docker login --username AWS --password-stdin 468416635228.dkr.ecr.us-east-1.amazonaws.com

# Change the number 3 with the latest working version of the image
docker pull 468416635228.dkr.ecr.us-east-1.amazonaws.com/coworking:3

# Get port from the script analytics/app.py
docker run -d -p 5153:5153 468416635228.dkr.ecr.us-east-1.amazonaws.com/coworking:3
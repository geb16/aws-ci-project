# # start_container.sh
# #!/bin/bash
# set -e

# # Pull the Docker image from Docker Hub
# docker pull zawya20/simple-python-flask-app

# # Run the Docker image as a container
# docker run -d -p 5000:5000 zawya20/simple-python-flask-app   # add here if you have additional apps to run like bin bash.

# # -d 
# # -t


#!/bin/bash
set -e

APP_NAME="sample-flask-app"
IMAGE="zawya20/simple-python-flask-app:latest"

# Stop and remove any existing container with the same name
docker rm -f $(docker ps -aq -f name=$APP_NAME) 2>/dev/null || true

# Pull the latest Docker image from Docker Hub
docker pull $IMAGE

# Run the new Docker image as a container
docker run -d -p 5000:5000 --name $APP_NAME $IMAGE

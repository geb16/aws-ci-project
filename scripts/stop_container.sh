# stop_cnontainer.sh
#!/bin/bash
# set -e

# # Stop the running container (if any)
# containerid=`docker ps | awk -F" " '{print $1}'`
# docker rm -f $containerid

#!/bin/bash
set -e

APP_NAME="sample-flask-app"

# Stop and remove the specific app container if it exists
if [ "$(docker ps -aq -f name=$APP_NAME)" ]; then
    docker rm -f $(docker ps -aq -f name=$APP_NAME)
fi

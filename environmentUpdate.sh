#!/bin/bash

IMAGE_TAG="latest"

update_environment(){
    docker pull alpine:$IMAGE_TAG

    # stop and remove the existing containers
    docker-compose down

    docker-compose up -d
}

monitor_changes(){
    while true; do
        latest_tag=$(docker image ls alpine --format "{{.Tag}}")

        if [[ "$latest_tag" != "$IMAGE_TAG" ]]; then
            echo "New image tag available: $latest_tag"
            echo "Update environment..."
            IMAGE_TAG="$latest_tag"
            update_environment
        fi
        sleep 60 # sleep for a while before checking again...
    done
}
monitor_changes

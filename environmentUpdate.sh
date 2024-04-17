#!/bin/bash

get_image_name(){
  local image_name=$(grep "image:" docker-compose.yml | awk -F':' '{print $2}' | tr -d '[:space:]')
  echo "$image_name"
}

get_image_tag(){
  local image_tag=$(grep "image:" docker-compose.yml | awk -F':' '{print $3}' | awk '{print $NF}')
  echo "$image_tag"
}

update_environment(){
  local image_name=$(get_image_name)
  local image_tag=$(get_image_tag)
  docker pull "$image_name:$image_tag" # pul img the latest change

  # stop and remove the existing containers
  docker-compose down

  docker image rm "$image_name:$image_tag" # del img with old tag
  docker-compose up -d
}

# check to see if the image on the .yml file
if ! grep -q "image: " docker-compose.yml; then
  echo "ERROR: Image not found in the docker-compose.yml file."
  exit 1
fi

# check if image is already running
if ! docker image inspect "$(get_image_name):$(get_image_tag)" >/dev/null 2>&1; then
  echo "ERROR: Image '$(get_image_name):$(get_image_tag)' is not running."
  echo "Pulling '$(get_image_name):$(get_image_tag)'..."
  update_environment
fi

add_cron_job(){
  (crontab -l ; echo "$1") | crontab -
}

remove_cron_job(){
  crontab -l | grep -v "$1" | crontab -
}

schedule_day(){
  add_cron_job "* * * * * /bin/bash -c 'cd $(pwd) && ./environmentUpdate.sh"
}

schedule_night(){
  add_cron_job "0 0 * * * /bin/bash -c 'cd $(pwd) && ./environmentUpdate.sh"
}

monitor_changes(){
  local previous_name=$(get_image_name)
  local previous_tag=$(get_image_tag)

    while true; do
      local latest_tag=$(get_image_tag)
      local latest_name=$(get_image_name)

      if [[ "$latest_name" != "$previous_name" || "$latest_tag" != "$previous_tag" ]]; then
        echo -e " "
        echo "Update available: $latest_name:$latest_tag"
        echo "Update environment..."
        update_environment
        previous_tag=$(get_image_tag)
        previous_name=$(get_image_name)
      fi
    done
}
schedule_day
monitor_changes
## Recurrent pull and restart of environment shell script

# Overview

This script is designed to automate the process of updating a Docker-based environment.
It continuously monitors for changes in the specified Docker image tag and  updates the environment accordingly.

# Usage
1. Make sure you have Docker and Docker Compose installed on your system.
2. Create a file(.sh) and copy the script code into it.
3. Open the terminal(Alt+Ctl+T), navigate to where the script is located.
4. Make the script executable
    ```shell
    chmod u+x script_name.sh
    ```
5. Install `inotifywait`
   ```shell
   apt-get install inotify-tools
   ```
6. Execute the script
    ```shell
    ./script_name.sh
    ```
The script will start pull the specified image tag(alpine:latest according to my code) and deploying the environment using `docker-compose`.
It will then continuously monitor for changes in the image tag every 60 seconds(according to my code). If a new image tag becomes available, the script will update the environment by pulling the latest version of the image and redeploying the containers.

# Test the script
1. Run the script. It will run indefinitely.
2. Open another terminal window(Ctl+Shift+T), check the current running image tags being used.
    ```shell
    docker image ls your_image(alpine in my case)
    ```
   Note the tag being used.
3. Tag a new version of the image
    ```shell
    docker tag your_image:latest your_image:new_tag(e.g 3.14)
    ```
4. Return to the first terminal window and monitor the result.


# Note
Your docker-compose.yml and Dockerfiles should be in the same directory as the script file.
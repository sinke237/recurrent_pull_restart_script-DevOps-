## Authentication

1. Create a file `.json` (e.g sk-registry.json) in the directory `~/.docker/config.json.d/`. Create this directory if it does not exist.
2. Setup the helper environment
   ```dockerfile
   export DOCKER_CONFIG_JSON=$HOME/.docker/config.json
   ```
   To tell docker to use this configuration file for credentials.
3. Mounting the volume `~/.docker/config.json:/root/.docker/config.json:ro` to watchtower container as read-only
   volume (`/root/.docker/config.json`). This lets watchtower to access the credentials stored in the credential helper through the configuration file.
4. Login in the terminal
   ```dockerfile
   docker login sinke-registry:5000 -u admin  --password-stdin adminsk-registry
   ```
## Setup
The defined network named sk_network is helpful as other services needs to communicate with the registry and watchtower.

Build images from the Dockerfile.
```dockerfile
docker build -t sinke-registry:5000/sk-nginx:stable-alpine3.17 .
```
Push this image to the private registry
```dockerfile
docker push sinke-registry:5000/sk-nginx:stable-alpine3.17
```
You can push and build in one step 
```dockerfile
docker build -t sinke-registry:5000/sk-nginx:stable-alpine3.17 --push .
```
## Usage

1. Run the docker-compose services
    ```shell
    docker-compose up -d
    ```
2. Check the watchtower logs
    ```shell
    docker-compose logs -f watchtower
    ```
3. To confirm that the app container has been updated
   ```shell
   docker-compose logs -f app
   ```

## Debug
To search keywords from the logs
```shell
docker-compose logs -f watchtower | grep "Found updated image"
```

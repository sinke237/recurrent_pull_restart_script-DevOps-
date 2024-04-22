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
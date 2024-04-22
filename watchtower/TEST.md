## Docs for testing

Watchtower monitors the images in the registry and make comparism with the one running in the environment.
To verify the watchtower is working. 
I will create a local docker registry and use it to test if watchtower works.

1. To create a local registry
    ```dockerfile
    docker run -d -p 5000:5000 --restart=always --name sinke-registry registry:2
    ```
2. Pull three public images to my local machine
    ```dockerfile
    docker pull nginx:latest
    ```
   ```dockerfile
    docker pull redis:latest
    ```
   ```dockerfile
    docker pull mysql:latest
    ```
3. Alter the tags ()
    ```dockerfile
    docker tag nginx:latest localhost:5000/my-nginx:2.8
    ```
    ```dockerfile
    docker tag redis:latest localhost:5000/my-redis:3.4
    ```
    ```dockerfile
    docker tag mysql:latest localhost:5000/my-mysql:3.2
    ```
4. Push each of them to the create local registry
    ```dockerfile
    docker push localhost:5000/my-mysql:3.2
    ```
    ```dockerfile
    docker push localhost:5000/my-redis:3.4
    ```
    ```dockerfile
    docker push localhost:5000/my-nginx:2.8
    ```
5. Check the images in the registry
    ```dockerfile
    curl -X GET http://localhost:5000/v2/_catalog
    ```
6. Check the different tags for each image
   ```dockerfile
   curl -X GET http://localhost:5000/v2/my-nginx/tags/list
   ```

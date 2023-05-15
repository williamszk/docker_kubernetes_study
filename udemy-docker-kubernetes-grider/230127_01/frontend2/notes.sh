docker build -t my-react-docker-image -f Dockerfile .

# nginx uses port 80 inside the container
docker run -it \
    -p 8080:80 \
    --name my-container-docker-react \
    my-react-docker-image

docker stop my-container-docker-react
docker rm my-container-docker-react



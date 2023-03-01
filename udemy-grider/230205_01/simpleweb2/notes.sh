npm i express 
npm i axios 

cd simpleweb2
docker build -t williamszk/simpleweb .

# [inside simpleweb2]
docker run -d --name test-container \
    -p 8080:8080 \
    -v ./index.js:/usr/app/index.js \
    williamszk/simpleweb

# This will tell that we want to keep the node_module inside the container.
# -v /usr/app/node_module \

docker ps -a
docker stop test-container
docker rm test-container
docker logs -t test-container

docker exec -it test-container sh 


docker stop test-container 
docker start test-container 

mkdir visits
cd visits
touch package.json
touch index.js
touch Dockerfile
touch docker-compose.yaml 

docker build -t williamszk/visits:latest .

# [inside visits]
docker run -d --name test-container \
    -p 8081:8081 \
    williamszk/visits

docker ps -a
docker stop test-container
docker rm test-container
docker logs -t test-container

docker exec -it test-container sh 

docker stop test-container 
docker start test-container 

docker run redis

# ----------------------------------------------------------------
# With "docker compose" always run the commands inside the directory
# where the docker-compose.yaml is present.
cd visits
docker compose up -d --build
docker compose down
docker compose start

docker compose ps 

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
cd visits
docker-compose up --build
docker-compose down
docker-compose start


cd client
docker build -t client-image -f Dockerfile.dev .
docker run client-image

cd server
docker build -t server-image -f Dockerfile.dev .
docker run server-image

cd worker
docker build -t worker-image -f Dockerfile.dev .
docker run worker-image

docker-compose down && docker-compose up --build
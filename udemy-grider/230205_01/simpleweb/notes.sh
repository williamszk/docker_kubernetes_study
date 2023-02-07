npm i express 

docker build -t williamszk/node_app .

docker run -d --name test-container -p 8080:8080 williamszk/node_app
docker stop test-container
docker rm test-container
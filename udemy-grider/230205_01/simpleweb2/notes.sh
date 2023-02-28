npm i express 
npm i axios 

cd simpleweb
docker build -t williamszk/simpleweb .

docker run -d --name test-container -p 8080:8080 williamszk/simpleweb
docker stop test-container
docker rm test-container

docker exec -it test-container sh 
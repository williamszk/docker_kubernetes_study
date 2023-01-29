
sudo apt update
sudo apt upgrade -y

sudo apt install npm -y

sudo npm install -g n

node -v
sudo n stable

sudo npm install -g create-react-app

create-react-app frontend

cd frontend

npm run start 
npm run test
npm run build

sudo apt install net-tools
sudo netstat -nlp | grep :3000

cd frontend
touch Dockerfile.dev

touch .dockerignore

docker build -t my-react-docker-image -f Dockerfile.dev .

docker run -d -p 3000:3000 --name my-container-docker-react my-react-docker-image
docker stop my-container-docker-react
docker rm my-container-docker-react

# docker run with volumes to automatic update inside container
docker run \
    -p 3000:3000 \
    -v $(pwd):/app \
    --name my-container-docker-react \
    my-react-docker-image

touch docker-compose.yaml

sudo apt install docker-compose 

docker-compose up
docker-compose stop
docker-compose start 
docker-compose down 

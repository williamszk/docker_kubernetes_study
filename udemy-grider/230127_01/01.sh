
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

docker-compose up --build -d
docker-compose up
docker-compose stop
docker-compose start 
docker-compose down 

# running tests inside the container
docker build -t my-react-docker-image-test -f Dockerfile.test .

docker run -it \
    -p 3000:3000 \
    --name my-container-docker-react-test \
    my-react-docker-image-test

docker stop my-container-docker-react-test
docker rm my-container-docker-react-test

docker exec -it frontend_tests_1 sh 
# attach to the primairy process of the container
docker attach frontend_tests_1
# the primary process has id of 1
# we can run $ ps to see which process has id of 1

# ============================================================================
# Second phase of the project
create-react-app frontend2
cd frontend2










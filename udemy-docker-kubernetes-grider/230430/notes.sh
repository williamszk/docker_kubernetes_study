
npx create-react-app frontend

cd frontend
npm run start
npm run test
npm run build

cd frontend
touch Dockerfile.dev
touch Dockerfile

cd frontend
sudo docker build -t william/my-study-image -f Dockerfile.dev .

# to run a docker container
sudo docker run -p 3000:3000 --name my-docker-image william/my-study-image

cd frontend

sudo docker run -p 3000:3000 \
    -v /home/node/app/node_modules \
    -v $(pwd):/home/node/app \
    --name my-docker-image \
    william/my-study-image

# in -v where there is no : (colon) we tell docker to map a dir inside
# the container to the host machine 
# there is no node_modules inside the container so we need to map it out
# to the host machine

# React server running on my local server
# http://192.168.15.3:3000/
sudo docker stop my-docker-image
sudo docker rm my-docker-image

# ==============================================================================
cd frontend
docker compose up --build -d
docker compose up --build
docker compose stop
docker compose ls
docker compose down

# ==============================================================================

cd frontend
sudo docker build -t william/my-study-image -f Dockerfile.dev .

# run test
sudo docker run -p 3000:3000 \
    -it \
    -v /home/node/app/node_modules \
    -v $(pwd):/home/node/app \
    --name my-docker-image \
    william/my-study-image \
    npm run test

sudo docker stop my-docker-image
sudo docker rm my-docker-image

# ==============================================================================
# this is not a good solution to interact with the "npm run test" 
# a better alternative is to use "docker exec -it"
# stdin, stdout, stderr 
docker attach frontend-test-1

# ==============================================================================
# building image for nginx and react
cd frontend
sudo docker build -t william/my-study-image-deploy .

sudo docker run -p 8080:80 \
    --name my-docker-react-nginx \
    william/my-study-image-deploy

sudo docker stop my-docker-react-nginx 
sudo docker rm my-docker-react-nginx
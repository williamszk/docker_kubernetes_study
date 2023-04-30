
npx create-react-app frontend

cd frontend
npm run start
npm run test
npm run build

cd frontend
touch Dockerfile.dev
touch Dockerfile

cd frontend
docker build -t william/my-study-image -f Dockerfile.dev .

# to run a docker container
docker run -p 3000:3000 --name my-docker-image william/my-study-image

docker run -p 3000:3000 \
    -v /usr/app/node_modules \
    -v $(pwd):/usr/app \
    --name my-docker-image \
    william/my-study-image

# React server running on my local server
# http://192.168.15.3:3000/
docker stop my-docker-image
docker rm my-docker-image
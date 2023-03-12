
# https://www.udemy.com/course/docker-and-kubernetes-the-complete-guide/learn/lecture/11437040?start=15#overview

node -v

npx create-react-app frontend
cd frontend

npm run start
npm run test
npm run build

docker build -t william/my-study-image -f Dockerfile.dev .
docker run -p 3000:3000 --name my-docker-image william/my-study-image
docker run -p 3000:3000 -v /usr/app/node_modules -v $(pwd):/usr/app --name my-docker-image william/my-study-image
# bookmarking volumes
# we write -v /app/node_modules because there is no 
# node_modules in the host machine, so we need to tell docker
# to not try to use a node_modules of the host machine and keep the
# one that is inside the container, for that we just don't write a :

docker stop my-docker-image
docker rm my-docker-image















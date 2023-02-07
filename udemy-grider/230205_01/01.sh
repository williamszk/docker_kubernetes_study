docker run --name test-container hello-world 
docker ps -a
docker ps --all

# overwrite the default command of the image the CMD
docker run --name test-container busybox echo "Hello World"
docker stop test-container
docker rm test-container

# create and then start the container
container_id=$(docker create hello-world)
docker start -a $container_id

docker create hello-world | xargs docker start -a

# overwrite the default command in docker create
docker create busybox echo hi there again from docker

# how to run a container to just poke around with the terminal?
docker run --name test-container -it busybox sh
docker stop test-container
docker rm test-container










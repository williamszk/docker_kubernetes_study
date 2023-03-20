# Notes inspired by:
# https://jpetazzo.github.io/2015/09/03/do-not-use-docker-in-docker-for-ci/

docker run -d \
	-v /var/run/docker.sock:/var/run/docker.sock \
	--name study-container-2 \
	-it ubuntu bash


docker stop study-container-2
docker rm study-container-2



# To start a new container from the container 
# Start a sibling container

# Go into the container and run some commands
docker exec -it study-container-2 bash


 apt-get update
 apt-get install \
	ca-certificates \
	curl \
	gnupg \
	lsb-release -y

mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	    $(lsb_release -cs) stable" |  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update

apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

docker run hello-world





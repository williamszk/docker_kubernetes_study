
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

docker build -t my-react-docker-image -f Dockerfile.dev .



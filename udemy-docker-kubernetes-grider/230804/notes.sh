
mkdir complex
cd complex

mkdir worker
mkdir another_folder

cd worker
touch package.json
touch index.js
touch keys.js

cd complex/worker
node index.js

cd complex
mkdir server
cd server
touch package.json
touch keys.js




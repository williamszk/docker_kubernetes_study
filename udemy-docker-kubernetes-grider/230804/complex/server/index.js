const keys = require('./keys.js');

// Express App Setup
const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Postgres Client Setup
const { Pool } = require('pg');
const pgClient = new Pool({
	user: keys.pgUser,
	host: keys.pgHost,
	database: keys.pgDatabase,
	password: keys.pgPassword,
	port: keys.pgPort,
});

pgClient.on('connect', (client) => {
	client
		.query('CREATE TABLE IF NOT EXISTS values (number INT)')
		.catch((err) => console.error(err));
});

// Redis Client Setup
const redis = require('redis');
const redisClient = redis.createClient({
	host: keys.redisHost,
	port: keys.redisPort,
	retry_strategy: () => 1000,
});

const redisPublisher = redisClient.duplicate();

// Express Route Handlers
app.get('/', (req, res) => {
	res.send('Hey there!');
});

app.get('/values/all', async (req, res) => {
	const values = await pgClient.query('SELECT * FROM values');
	res.send(values.rows);
});

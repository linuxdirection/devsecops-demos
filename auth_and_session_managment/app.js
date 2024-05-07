// Import necessary libraries
const express = require('express');
const session = require('express-session');
const bodyParser = require('body-parser');
const path = require('path');
const bcrypt = require('bcrypt');
require('dotenv').config();

const app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

// Configure session with a secret key from environment variables
app.use(session({
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: true
}));

app.get('/', (req, res) => {
  res.send('Home Page');
});

app.get('/login', (req, res) => {
  res.sendFile(path.join(__dirname, 'login.html'));
});

// Handling login with password verification
app.post('/login', (req, res) => {
  let { username, password } = req.body;
  const userPasswordFromEnv = process.env.USER_PASSWORD;

  // Hash the environment variable password when comparing
  const hashedPassword = bcrypt.hashSync(userPasswordFromEnv, 10);
  
  if (username === 'admin' && bcrypt.compareSync(password, hashedPassword)) {
    req.session.user = username;
    res.status(200).send('Logged in!');
  } else {
    res.status(401).send('Login failed');
  }
});

app.listen(3000, () => console.log('App running on port 3000'));

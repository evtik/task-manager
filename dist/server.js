var app, db, express, mongoose;

process.env.NODE_ENV = process.env.NODE_ENV || 'development';

mongoose = require('./config/mongoose');

express = require('./config/express');

db = mongoose();

app = express();

app.listen(process.env.PORT || 3000);

module.exports = app;

console.log("Environment is " + process.env.NODE_ENV);

console.log("Server running...");

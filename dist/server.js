var app, db, express, mongoose, passport;

process.env.NODE_ENV = process.env.NODE_ENV || 'development';

mongoose = require('./config/mongoose');

express = require('./config/express');

passport = require('./config/passport');

db = mongoose();

app = express();

passport = passport();

app.listen(process.env.PORT || 3000);

module.exports = app;

console.log("Environment is " + process.env.NODE_ENV);

console.log("Server running...");

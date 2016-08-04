var bodyParser, config, express, http, morgan, path;

config = require('./config');

http = require('http');

express = require('express');

morgan = require('morgan');

path = require('path');

bodyParser = require('body-parser');

module.exports = function() {
  var app, server;
  app = express();
  server = http.createServer(app);
  if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'));
  }
  app.use(bodyParser.urlencoded({
    extended: true
  }));
  app.use(bodyParser.json());
  app.set('views', __dirname + '/../app/views');
  app.set('view engine', 'jade');
  (require('../app/routes/index.server.routes'))(app);
  app.use(express["static"](path.join(__dirname + '/../public')));
  return server;
};

var bodyParser, compress, config, express, http, methodOverride, morgan, path, session;

config = require('./config');

http = require('http');

express = require('express');

morgan = require('morgan');

compress = require('compression');

path = require('path');

bodyParser = require('body-parser');

methodOverride = require('method-override');

session = require('express-session');

module.exports = function() {
  var app, server;
  app = express();
  server = http.createServer(app);
  if (process.env.NODE_ENV === 'development') {
    app.use(morgan('dev'));
  } else {
    app.use(compress());
  }
  app.use(bodyParser.urlencoded({
    extended: true
  }));
  app.use(bodyParser.json());
  app.use(methodOverride());
  app.locals.basedir = path.join(__dirname, '/../app/views');
  app.set('views', __dirname + '/../app/views');
  app.set('view engine', 'jade');
  (require('../app/routes/index.server.routes'))(app);
  (require('../app/routes/users.server.routes'))(app);
  app.use(express["static"](path.join(__dirname + '/../public')));
  return server;
};

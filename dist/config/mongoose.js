var config, mongoose;

config = require('./config');

mongoose = require('mongoose');

mongoose.Promise = global.Promise;

module.exports = function() {
  var db;
  db = mongoose.connect(config.db);
  require('../app/models/user.server.model');
  return db;
};

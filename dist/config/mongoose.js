var config, mongoose;

config = require('./config');

mongoose = require('mongoose');

module.exports = function() {
  var db;
  db = mongoose.connect(config.db);
  require('../app/models/user.server.model');
  return db;
};

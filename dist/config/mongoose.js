var config, mongoose;

config = require('./config');

mongoose = require('mongoose');

module.exports = function() {
  var db;
  return db = mongoose.connect(config.db);
};

var mongoose, passport;

passport = require('passport');

mongoose = require('mongoose');

module.exports = function() {
  var User;
  User = mongoose.model('User');
  passport.serializeUser(function(user, done) {
    return done(null, user._id);
  });
  passport.deserializeUser(function(id, done) {
    return User.findOne({
      _id: id
    }, '-password -salt', function(err, user) {
      return done(err, user);
    });
  });
  (require('./strategies/local'))();
  return null;
};

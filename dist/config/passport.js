var mongoose, passport;

passport = require('passport');

mongoose = require('mongoose');

module.exports = function() {
  var User;
  User = mongoose.model('User');
  passport.serializeUser(function(user, done) {
    return done(null, user.id);
  });
  passport.deserializeUser(function(id, done) {
    return User.findOne({
      _id: id
    }, '-password -salt', function(err, user) {
      return done(err, user);
    });
  });
  return (require('./strategies/local'))();
};

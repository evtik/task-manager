var LocalStrategy, User, passport;

passport = require('passport');

LocalStrategy = require('passport-local').Strategy;

User = require('mongoose').model('User');

module.exports = function() {
  return passport.use(new LocalStrategy(function(username, password, done) {
    return User.findOne({
      username: username
    }, function(err, user) {
      if (err) {
        return done(err);
      }
      if (!user) {
        return done(null, false, {
          message: 'Unknown user'
        });
      }
      if (!user.authenticate(password)) {
        return done(null, false, {
          message: 'Invalid password'
        });
      }
      return done(null, user);
    });
  }));
};

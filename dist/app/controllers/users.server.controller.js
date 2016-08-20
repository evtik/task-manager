var User, getErrorMessages, passport;

User = require('mongoose').model('User');

passport = require('passport');

getErrorMessages = function(err) {
  var errors, k, v, _ref;
  if (err.code) {
    switch (err.code) {
      case 11000:
      case 11001:
        return ['This user name already exists'];
      default:
        return ["MongoDB " + err.code + " error"];
    }
  } else if (err.errors) {
    errors = [];
    _ref = err.errors;
    for (k in _ref) {
      v = _ref[k];
      if (v.message) {
        errors.push(v.message);
      }
    }
    return errors;
  } else if (err.message) {
    return [err.message];
  } else {
    return ['Unknown server error'];
  }
};

exports.authenticate = function(req, res, next) {
  var auth;
  auth = passport.authenticate('local', function(err, user) {
    if (err) {
      return next(err);
    }
    if (!user) {
      return res.send({
        success: false
      });
    } else {
      return req.logIn(user, function(err) {
        if (err) {
          return next(err);
        }
        return res.send({
          success: true,
          user: user
        });
      });
    }
  });
  return auth(req, res, next);
};

exports.create = function(req, res, next) {
  var user;
  user = new User(req.body);
  return user.save(function(err) {
    if (err) {
      return res.status(400).send({
        errorMessages: getErrorMessages(err)
      });
    } else {
      return req.logIn(user, function(err) {
        if (err) {
          return next(err);
        }
        return res.json(user);
      });
    }
  });
};

exports.read = function(req, res) {
  return res.json(req.user);
};

exports.userByID = function(req, res, next, id) {
  return User.findOne({
    _id: id
  }, function(err, user) {
    if (err) {
      return next(err);
    } else {
      req.user = user;
      return next();
    }
  });
};

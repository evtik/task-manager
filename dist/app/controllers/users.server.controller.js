var User;

User = require('mongoose').model('User');

exports.create = function(req, res, next) {
  var user;
  user = new User(req.body);
  return user.save(function(err) {
    if (err) {
      return next(err);
    } else {
      return res.json(user);
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

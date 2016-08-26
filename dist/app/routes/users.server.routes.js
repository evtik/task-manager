var users;

users = require('../../app/controllers/users.server.controller');

module.exports = function(app) {
  app.route('/api/users').post(users.create);
  app.route('/login').post(users.authenticate);
  app.route('/logout').post(function(req, res) {
    req.logOut();
    req.session.destroy();
    return res.end();
  });
  app.route('/user/exists/').post(users.userByUsername);
  return app.param('userId', users.userByID);
};

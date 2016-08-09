var users;

users = require('../../app/controllers/users.server.controller');

module.exports = function(app) {
  app.route('/api/users').post(users.create);
  app.route('/api/users/:userID').get(users.read);
  return app.param('userID', users.userByID);
};

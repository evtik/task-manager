var users;

users = require('../../app/controllers/users.server.controller');

module.exports = function(app) {
  app.route('/api/users').post(users.create);
  app.route('/api/users/:userId').get(users.read);
  return app.param('userId', users.userByID);
};

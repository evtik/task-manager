var projects, users;

users = require('../../app/controllers/users.server.controller');

projects = require('../../app/controllers/projects.server.controller');

module.exports = function(app) {
  app.route('/api/users/:userId/projects').get(users.requiresLogin, projects.list).post(users.requiresLogin, projects.create);
  app.route('/api/users/:userId/projects/:projectId').put(users.requiresLogin, projects.hasAuthorization, projects.update)["delete"](users.requiresLogin, projects.hasAuthorization, projects["delete"]);
  return app.param('projectId', projects.projectByID);
};

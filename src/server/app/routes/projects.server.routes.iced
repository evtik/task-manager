users = require '../../app/controllers/users.server.controller'
projects = require '../../app/controllers/projects.server.controller'

module.exports = (app) ->
	app.route '/api/users/:userId/projects'
		.get users.requiresLogin, projects.list
		# .get projects.list
		.post users.requiresLogin, projects.create

	app.route '/api/users/:userId/projects/:projectId'
		.put users.requiresLogin, projects.hasAuthorization, projects.update
		.delete users.requiresLogin, projects.hasAuthorization, projects.delete

	# app.param 'userId', users.userByID
	app.param 'projectId', projects.projectByID
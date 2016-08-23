users = require '../../app/controllers/users.server.controller'

module.exports = (app) ->

	app.route '/api/users'
		.post users.create
	app.route '/api/users/:userId'
		.get users.read
	app.route '/login'
		.post users.authenticate
	app.route '/logout'
		.post (req, res) ->
			req.logout()
			res.end()
	app.route '/user/exists/'
		.post users.userByUsername
	app.param 'userId', users.userByID
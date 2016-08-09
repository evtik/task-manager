users = require '../../app/controllers/users.server.controller'

module.exports = (app) ->
	app.route('/api/users').post users.create

	app.route('/api/users/:userID').get users.read

	app.param 'userID', users.userByID
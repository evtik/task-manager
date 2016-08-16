users = require '../../app/controllers/users.server.controller'

module.exports = (app) ->
	# app.route('/api/users').post (err, req, res, next) ->
	# 		console.log err.stack
	# 		res.status(500).send error: err
	# 	, users.create

	app.route '/api/users'
		.post users.create

	app.route '/api/users/:userId'
		.get users.read

	app.param 'userId', users.userByID
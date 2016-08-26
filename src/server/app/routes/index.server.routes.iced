module.exports = (app) ->
	index = require '../controllers/index.server.controller'

	app.all '/api/*', (req, res) ->
		# res.send 404
		res.redirect '/'

	app.get '/', index.render
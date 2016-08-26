module.exports = (app) ->

	app.all '/api/*', (req, res) ->
		res.send 404
module.exports = (app) ->
	index = require '../controllers/index.server.controller'
	app.get '/', index.render
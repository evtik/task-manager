config = require './config'
http = require 'http'
express = require 'express'
morgan = require 'morgan'
compress = require 'compression'
path = require 'path'
bodyParser = require 'body-parser'
methodOverride = require 'method-override'
session = require 'express-session'
MongoStore = require('connect-mongo') session
passport = require 'passport'

module.exports = (db) ->
	app = express()
	server = http.createServer app

	if process.env.NODE_ENV is 'development'
		app.use morgan 'dev'
	else
		app.use compress()

	app.use bodyParser.urlencoded(extended: on)
	app.use bodyParser.json()
	app.use methodOverride()

	# mongoStore = new MongoStore db: db.connection.db
	mongoStore = new MongoStore mongooseConnection: db.connection

	app.use session
		saveUninitialized: off
		resave: on
		secret:config.sessionSecret
		store: mongoStore

	app.locals.basedir = path.join __dirname, '/../app/views'
	app.set 'views', __dirname + '/../app/views'
	app.set 'view engine', 'jade'

	app.use passport.initialize()
	app.use passport.session()

	(require '../app/routes/users.server.routes')(app)
	(require '../app/routes/projects.server.routes')(app)
	(require '../app/routes/index.server.routes')(app)

	app.use express.static(path.join(__dirname + '/../public'))

	server
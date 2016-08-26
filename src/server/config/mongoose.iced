config = require './config'
mongoose = require 'mongoose'

mongoose.Promise = global.Promise

module.exports = () ->
	db = mongoose.connect config.db
	require '../app/models/user.server.model'
	require '../app/models/project.server.model'
	db
config = require './config'
mongoose = require 'mongoose'

module.exports = () ->
	db = mongoose.connect config.db
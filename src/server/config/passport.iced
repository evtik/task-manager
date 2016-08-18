mongoose = require 'mongoose'
passport = require 'passport'

module.exports = () ->

	User = mongoose.model 'User'

	passport.serializeUser (user, done) ->
		done null, user._id

	passport.deserializeUser (id, done) ->
		User.findOne _id: id, '-password -salt', (err, user) ->
			done err, user

	(require './strategies/local')()

	null
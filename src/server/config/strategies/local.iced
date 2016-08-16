passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
User = require('mongoose').model 'User'

module.exports = () ->
	passport.use new LocalStrategy (username, password, done) ->
		User.findOne username: username, (err, user) ->
			if err
				return done err

			if !user
				return done null, off, message: 'Unknown user'

			if !user.authenticate password
				return done null, off, message: 'Invalid password'

			return done null, user
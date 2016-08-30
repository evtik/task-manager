User = require('mongoose').model 'User'
passport = require 'passport'

getErrorMessages = (err) ->
	if err.code
		switch err.code
			when 11000, 11001
				return ['This user name already exists']
			else
				return ["MongoDB #{err.code} error"]
	else if err.errors
		errors = []
		for k, v of err.errors
			if v.message
				errors.push v.message
		return errors
	else if err.message
		return [err.message]
	else
		return ['Unknown server error']

exports.authenticate = (req, res, next) ->
	auth = passport.authenticate 'local', (err, user) ->
		if err
			return next err
		if !user
			res.send success:off
		else
			req.logIn user, (err) ->
				if err
					return next err
				return res.send success: on, user: user
	auth req, res, next
	null

exports.create = (req, res, next) ->
	user = new User req.body

	user.save (err) ->
		if err
			res.status(400).send errorMessages: getErrorMessages err
		else
			req.logIn user, (err) ->
				if err
					return next err
				res.json user

exports.userByUsername = (req, res, next) ->
	User.findOneByUsername req.body.userName, (err, user) ->
		if err
			return next err
		if !user
			res.send exists: off
		else
			res.send exists: on

exports.read = (req, res) ->
	res.json req.user

exports.userByID = (req, res, next, id) ->
	User.findOne _id: id, (err, user) ->
		if err
			return next err
		else
			req.user = user
			next()

exports.requiresLogin = (req, res, next) ->
	if !req.isAuthenticated()
		return res.status(401).send message: 'User is not logged in'
	next()
mongoose = require 'mongoose'
User = mongoose.model 'User'

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


exports.create = (req, res) ->
	user = new User req.body

	user.save (err) ->
		if err
			res.status(400).send errorMessages: getErrorMessages err
		else
			res.json user

exports.read = (req, res) ->
	res.json req.user

exports.userByID = (req, res, next, id) ->
	User.findOne _id: id, (err, user) ->
		if err
			return next err
		else
			req.user = user
			next()
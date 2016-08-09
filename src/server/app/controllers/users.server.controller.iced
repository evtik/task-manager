User = require('mongoose').model 'User'

exports.create = (req, res, next) ->
	user = new User req.body

	user.save (err) ->
		if err
			return next err
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
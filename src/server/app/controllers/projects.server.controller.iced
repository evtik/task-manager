Project = require('mongoose').model 'Project'

getErrorMessages = (err) ->
	if err.errors
		errors = []
		for k, v of err.errors
			if v.message
				errors.push v.message
		errors
	else if err.message
		[err.message]
	else
		['Unknow server error']

exports.create = (req, res, next) ->
	# console.log req.body
	project = new Project req.body
	project.creator = req.user

	project.save (err) ->
		if err
			return res.status(400).send errorMessages: getErrorMessages err
		else
			res.json project

exports.list = (req, res) ->
	Project.find(creator: req.user).exec (err, projects) ->
		if err
			return res.status(400).send errorMessages: getErrorMessages err
		else
			res.json projects

exports.projectByID = (req, res, next, id) ->
	Project.findById(id).populate('creator', 'firstName lastName userName').exec (err, project) ->
		if err
			return next err
		if !project
			return next new Error 'Failed to load the project'
		req.project = project
		next()

exports.update = (req, res) ->
	project = req.project

	project.name = req.body.name
	project.tasks = req.body.tasks

	project.save (err) ->
		if err
			return res.status(400).send errorMessages: getErrorMessages err
		else
			res.json project

exports.delete = (req, res) ->
	project = req.project

	project.remove (err) ->
		if err
			return res.status(400).send errorMessages: getErrorMessages err
		else
			res.json project

exports.hasAuthorization = (req, res, next) ->
	# console.log req.user
	# console.log req.project
	unless req.user._id.equals req.project.creator._id
		return res.status(403).send message: 'User is not authorized'
	next()
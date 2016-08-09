mongoose = require 'mongoose'
Schema = mongoose.Schema

UserSchema = new Schema
	firstName:
		type: String
		required: 'At least your first name is required'
	lastName: String
	userName:
		type: String
		trim: on
		required: 'Username is required!'
		unique: on
	password:
		type: String
		validate: [
			(password) ->
				password.length >= 6
			,
			'Password should be 6 or more characters long'
		]

UserSchema.statics.findOneByUsername = (username, callback) ->
	@findOne username: new RegExp(username, 'i'), callback

UserSchema.methods.authenticate = (password) ->
	@password is password

mongoose.model 'User', UserSchema
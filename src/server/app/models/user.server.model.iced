mongoose = require 'mongoose'
crypto = require 'crypto'
Schema = mongoose.Schema

UserSchema = new Schema
	firstName:
		type: String
		trim: on
		required: 'At least your first name is required'
		validate: [
			(firstName) ->
				return /^[a-zа-я]+$/i.test firstName
			,
			'First name can contain only letters'
		]
	lastName:
		type: String
		trim: on
		validate: [
			(lastName) ->
				return /^[a-zа-я]+$/i.test lastName
			,
			'Last name can contain only letters'
		]
	userName:
		type: String
		trim: on
		required: 'Username is required!'
		validate: [
			(userName) ->
				return /^[a-zа-я0-9]+$/i.test userName
			,
			'Username can contain only letters and digits'
		]
		index:
			unique: on
	password:
		type: String
		required: 'Password is required'
		validate: [
			(password) ->
				return password and password.length >= 6
			,
			'Password should be 6 or more characters long'
		]
	confirmPassword: String
	salt: String

UserSchema.pre 'save', (next) ->
	unless @password and @confirmPassword and @password is @confirmPassword
		next new Error 'password mismatch'
	else
		@salt = new Buffer crypto.randomBytes(16).toString('base64'), 'base64'
		@password = @hashPassword @password
		@confirmPassword = undefined
		next()

UserSchema.statics.findOneByUsername = (username, callback) ->
	@findOne username: new RegExp(username, 'i'), callback

UserSchema.methods.hashPassword = (password) ->
	crypto.pbkdf2Sync(password, @salt, 10000, 64).toString 'base64'

UserSchema.methods.authenticate = (password) ->
	@password is @hashPassword(password)

mongoose.model 'User', UserSchema
mongoose = require 'mongoose'
Schema = mongoose.Schema

ProjectSchema = new Schema
	creator:
		type: Schema.ObjectId
		ref: 'User'
	created:
		type: Date
		default: Date.now
	name:
		type: String
		trim: on
		required: 'Your project needs a name'
	tasks: [
		content:
			type: String
			trim: on
			required: 'Task content should not be empty'
		deadline: Date
		done: Boolean
	]

mongoose.model 'Project', ProjectSchema
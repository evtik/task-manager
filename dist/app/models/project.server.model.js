var ProjectSchema, Schema, mongoose;

mongoose = require('mongoose');

Schema = mongoose.Schema;

ProjectSchema = new Schema({
  creator: {
    type: Schema.ObjectId,
    ref: 'User'
  },
  created: {
    type: Date,
    "default": Date.now
  },
  name: {
    type: String,
    trim: true,
    required: 'Your project needs a name'
  },
  tasks: [
    {
      content: {
        type: String,
        trim: true,
        required: 'Task content should not be empty'
      },
      deadline: Date,
      done: Boolean
    }
  ]
});

mongoose.model('Project', ProjectSchema);

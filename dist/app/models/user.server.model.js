var Schema, UserSchema, mongoose;

mongoose = require('mongoose');

Schema = mongoose.Schema;

UserSchema = new Schema({
  firstName: {
    type: String,
    required: 'At least your first name is required'
  },
  lastName: String,
  userName: {
    type: String,
    trim: true,
    required: 'Username is required!',
    unique: true
  },
  password: {
    type: String,
    validate: [
      function(password) {
        return password.length >= 6;
      }, 'Password should be 6 or more characters long'
    ]
  }
});

UserSchema.statics.findOneByUsername = function(username, callback) {
  return this.findOne({
    username: new RegExp(username, 'i')
  }, callback);
};

UserSchema.methods.authenticate = function(password) {
  return this.password === password;
};

mongoose.model('User', UserSchema);

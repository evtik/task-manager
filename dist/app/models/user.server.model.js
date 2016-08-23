var Schema, UserSchema, crypto, mongoose;

mongoose = require('mongoose');

crypto = require('crypto');

Schema = mongoose.Schema;

UserSchema = new Schema({
  firstName: {
    type: String,
    trim: true,
    required: 'At least your first name is required',
    validate: [
      function(firstName) {
        return /^[a-zа-я]+$/i.test(firstName);
      }, 'First name can contain only letters'
    ]
  },
  lastName: {
    type: String,
    trim: true,
    validate: [
      function(lastName) {
        return /^[a-zа-я]+$/i.test(lastName);
      }, 'Last name can contain only letters'
    ]
  },
  userName: {
    type: String,
    trim: true,
    required: 'Username is required!',
    validate: [
      function(userName) {
        return /^[a-zа-я0-9]+$/i.test(userName);
      }, 'Username can contain only letters and digits'
    ],
    index: {
      unique: true
    }
  },
  password: {
    type: String,
    required: 'Password is required',
    validate: [
      function(password) {
        return password && password.length >= 6;
      }, 'Password should be 6 or more characters long'
    ]
  },
  confirmPassword: String,
  salt: String
});

UserSchema.pre('save', function(next) {
  if (!(this.password && this.confirmPassword && this.password === this.confirmPassword)) {
    return next(new Error('password mismatch'));
  } else {
    this.salt = new Buffer(crypto.randomBytes(16).toString('base64'), 'base64');
    this.password = this.hashPassword(this.password);
    this.confirmPassword = void 0;
    return next();
  }
});

UserSchema.statics.findOneByUsername = function(username, callback) {
  return this.findOne({
    userName: new RegExp(username, 'i')
  }, callback);
};

UserSchema.methods.hashPassword = function(password) {
  return crypto.pbkdf2Sync(password, this.salt, 10000, 64).toString('base64');
};

UserSchema.methods.authenticate = function(password) {
  return this.password === this.hashPassword(password);
};

mongoose.model('User', UserSchema);

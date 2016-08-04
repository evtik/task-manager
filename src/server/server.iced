process.env.NODE_ENV = process.env.NODE_ENV || 'development'

mongoose = require './config/mongoose'
express = require './config/express'

db = mongoose()
app = express()

app.listen 3000
# app.listen()

module.exports = app

console.log process.env.NODE_ENV
console.log 'Server running at http://localhost:3000/'
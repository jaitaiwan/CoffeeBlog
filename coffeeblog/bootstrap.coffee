###
# @name bootstrap.coffee
# @author Daniel J Holmes
# @description Initialises the applications framework
###

# Load the application-wide config
config = require '../config'

# Load coffeeblog into memory
coffeeblog = require('./coffeeblog').singleton()

# Setup our express server ready for our applcation
express = require 'express'
app = express()
server = require('http')
	.createServer app

# Use express's default body parser so we don't have to
app.configure 'production', ->
	app.use express.bodyParser()
	app.use express.cookieParser config.cookie.secret

# Initialise the application then add routes
coffeeblog.init app

# Finally, serve a page
server.listen config?.port
###
# @name bootstrap.coffee
# @author Daniel J Holmes
# @description Initialises the applications framework
###

# Load the application-wide config
config = require '../config'

# Load coffeeblog into memory
coffeeblog = require('./coffeeblog').singleton()

# Load our benchmark helper
benchmark = require('../helpers/Helper.benchmark').singleton()

# Start the timer
benchmark.lap 'start'

# Load dependant packages
express = require 'express'
MongoStore = require('connect-mongo') express
http = require 'http'

# Setup our express server ready for our applcation
app = express()
server = http.createServer app

console.log MongoStore

# Use express's default body parser so we don't have to
app.use express.cookieParser config.cookie.secret
app.use express.session
	secret: config.cookie.secret
	store: new MongoStore config.db
app.use express.bodyParser()


# Initialise the application then add routes
coffeeblog.init app
benchmark.lap 'start'

# Finally, serve a page
server.listen config?.port

# Log The time it took to startup
benchmark.lap 'start'

process.on 'SIGINT', =>
	console.log "\x1B[33m\x1B[1m\x1b[7m SIGNINT \x1B[0m\x1B[33m Server is going down\x1B[0m \x1B[33m\x1B[1m\x1b[7m SIGINT \x1B[0m"
	benchmark.logTimeSinceStart()
	process.exit()
###
# @name Plugin.main.coffee
# @author Description
# @description Basic plugin class which sets up initial code for plugins
###

IO = require '../coffeeblog/log'
coffee = require 'coffee-script'
fs = require 'fs'
path = require 'path'

class Main
	routes: []
	hasRun: false

	init:(@Plugins) =>
		if typeof @routes is 'string'
			file = fs.readFileSync @routes
			@routes = eval (coffee.compile file.toString(), {bare:true})
		Plugins.on 'setupRoutes', (Router) =>
			@setupRoutes Router


	setupRoutes: (@Router) =>
		Router.addRoute route.method, route.address, route.callback for route in @routes

module.exports = Main
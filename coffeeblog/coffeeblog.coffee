###
# @name coffeeblog.coffee
# @author Daniel J Holmes
# @description Main coffeeblog class
###

util = require 'util'
events = require 'events'


class CoffeeBlog
	routes: [
		method:'get'
		callback: ->
			console.log arguments
		address: '/'
	]

	event: new events.EventEmitter
	
	instance = null	
	@singleton: ->
		instance ?= new CoffeeBlog
		instance

	init: (app) ->
		@event.emit 'beforeInit', app
		@setupRoutes app


	setupRoutes: (app) ->
		@event.emit 'setupRoutes', app
		app.get route.address, route.callback for route in @routes

	log: (message) ->
		util.log message

	logError: (message) ->
		util.error message

require('./plugins').init CoffeeBlog.singleton()


module.exports = CoffeeBlog.singleton()
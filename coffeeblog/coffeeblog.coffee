###
# @name coffeeblog.coffee
# @author Daniel J Holmes
# @description Main coffeeblog class
###

events = require 'events'
IO = require './log'

class CoffeeBlog
	plugins: require './plugins'
	router: require './router'

	event: new events.EventEmitter
	
	instance = null	
	@singleton: ->
		instance ?= new CoffeeBlog
		instance

	init: (app) ->
		@plugins.initialise()
		@setupRoutes app


	setupRoutes: (app) ->
		@router.initialise(app)
		@plugins.setupRoutes(@router)


module.exports = CoffeeBlog.singleton()
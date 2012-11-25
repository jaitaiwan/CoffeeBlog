###
# @name admin.coffee
# @author Daniel J Holmes
# @description Entrypoint for the back-end admin plugin
###

Plugin = require '../../library/Plugin.main'

class Admin extends Plugin
	routes: []

	init: (@Plugins) ->
		@routes = require './routes'
		super @Plugins
		@setupRoutes require '../../coffeeblog/router'

	setupRoutes: (Router) =>
		super Router



module.exports = new Admin
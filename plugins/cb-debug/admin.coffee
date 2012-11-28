###
# @name admin.coffee
# @author Daniel J Holmes
# @description Entrypoint for the back-end admin plugin
###

Plugin = require '../../library/Plugin.main'

class Admin extends Plugin
	routes: "#{__dirname}/routes.coffee"

	constructor: ->
		@routes = "#{__dirname}/routes.coffee"
		super arguments...

	init: (@Plugins) ->
		super Plugins
		@setupRoutes require '../../coffeeblog/router'






module.exports = Admin
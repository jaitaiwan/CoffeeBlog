###
# @name coffeeblog.coffee
# @author Daniel J Holmes
# @description Main coffeeblog class
###

events = require 'events'
IO = require './log'
Template = require './templates'
Plugins = require './plugins'
Router = require './router'
Database = require './database'
config = require '../config'
express = require 'express'
path = require 'path'

class CoffeeBlog
	router: Router.singleton()
	plugins: Plugins.singleton()
	template: new Template
	database: new Database config.db.db, config.db.host, config.db.user, config.db.password, config.db.collections

	event: new events.EventEmitter
	
	instance = null	
	@singleton: ->
		instance ?= new CoffeeBlog
		instance

	init: (app) ->
		app.use express.static path.resolve "#{__dirname}/../templates/#{config.template}/public"
		@database.start()
		@template.init()
		@plugins.initialise app
		@setupRoutes app


	setupRoutes: (app) ->
		@router.initialise app, @template

module.exports = CoffeeBlog
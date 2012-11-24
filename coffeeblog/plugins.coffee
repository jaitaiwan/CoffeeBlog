###
# @name plugins.coffee
# @author Daniel J Holmes
# @description Tries to load plugins and returns an array of those plugins
###

fs = require 'fs'
path = require 'path'

class Plugins


	init: (@coffeeBlog)->
		coffeeBlog.event.on 'beforeInit', =>
			@initialisePlugins()
		coffeeBlog.event.on 'setupRoutes', => 
			@setupRoutes()

	setupRoutes: (app) ->
		@coffeeBlog.log "Placeholder, setupRoutes called"

	initialisePlugins: ->
		fs.readdir path.resolve("#{__dirname}/../plugins/"), (err, data) =>
			if err
				@coffeeBlog.logError "The plugins folder is missing!"
				return false

			@plugins = []
			for pluginDir in data
				pluginDir = path.resolve "#{__dirname}/../plugins/#{pluginDir}"
				try
					pluginInfo = require "#{pluginDir}/config"
					pluginInfo.dir = pluginDir
					@plugins.push pluginInfo
					@coffeeBlog.log "Loaded plugin '#{pluginInfo.name}' from '#{path.relative(path.resolve('./'),pluginDir)}'"
				catch e
					@coffeeBlog.logError "Failed to load plugin from \"#{pluginDir}\""
				


module.exports = new Plugins
###
# @name plugins.coffee
# @author Daniel J Holmes
# @description Tries to load plugins and returns an array of those plugins
###

fs = require 'fs'
path = require 'path'
events = require 'events'
IO = require './log'
coffeeblog = require './coffeeblog'
class Plugins
	plugin: new events.EventEmitter

	instance = null
	@singleton: ->
		instance ?= new Plugins
		instance
		

	initialise: =>
		try
			data = fs.readdirSync path.resolve("#{__dirname}/../plugins/")
		catch e
			IO.logError "The plugins folder is missing!"
			return false
		@plugins = []
		for pluginDir in data
			pluginDir = path.resolve "#{__dirname}/../plugins/#{pluginDir}"
			try
				pluginInfo = require "#{pluginDir}/config"
				pluginInfo.dir = pluginDir
				@plugins.push pluginInfo
				IO.log "Loaded plugin '#{pluginInfo.name}' from '#{path.relative(path.resolve('./'),pluginDir)}'"
				try
					IO.log "Initialising plugin with entrypoint at '../#{path.relative(path.resolve('./'),pluginDir)}/#{pluginInfo.entrypoint}'"
					Plugin = require "../#{path.relative(path.resolve('./'),pluginDir)}/#{pluginInfo.entrypoint}"
					plug = new Plugin
					plug.init @plugin
					IO.log "Initialised plugin '#{pluginInfo.name}' at entrypoint '#{pluginInfo.entrypoint}'"
				catch e
					IO.logError "Failed to initialise '#{pluginInfo.name}' at entrypoint '#{pluginInfo.entrypoint}'"
					IO.debug e
			catch e
				IO.logError "Failed to load plugin from \"#{pluginDir}\""
				IO.debug e
		true

	reload: =>
		@Router.reset()
		@initialise()
				


module.exports = Plugins
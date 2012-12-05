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
		

	initialise: (app) =>
		try
			data = fs.readdirSync path.resolve("#{__dirname}/../plugins/")
		catch e
			IO.error "The plugins folder is missing!"
			return false
		@plugins = []
		for pluginDir in data
			if pluginDir[0...1] is "." then continue
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
					plug.init app
					IO.log "Initialised plugin '#{pluginInfo.name}' at entrypoint '#{pluginInfo.entrypoint}'"
				catch e
					IO.error "Failed to initialise '#{pluginInfo.name}' at entrypoint '#{pluginInfo.entrypoint}'"
					IO.debug e
			catch e
				IO.warn "Failed to load plugin from \"#{pluginDir}\""
				IO.debug e
		true

	reload: =>
		Router = require './router'
		IO.custom ""
		IO.custom "\x1B[1m\x1b[7m\n ---------- Re-Initialising Plugins ---------- \n\x1B[0m\n"
		Router.singleton().reset()
		@initialise()
				


module.exports = Plugins
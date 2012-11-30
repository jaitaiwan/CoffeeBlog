###
# @name cb-modules
# @author Daniel J Holmes
# @description A plugin which abstracts away dealing with req and response objects and provides an MVC interface
###

Plugin = require '../../library/Plugin.main'
IO = require '../../coffeeblog/log'
path = require 'path'
fs = require 'fs'
mvcHelper = require '../../helpers/Helper.mvc'
express = require 'express'
class cb_modules extends Plugin
	routes: []

	init: (@Plugins) ->
		super Plugins
		@loadModules()

	setupRoutes: (Router) =>
		super Router

	loadModules: =>
		try
			data = fs.readdirSync path.resolve("#{__dirname}/../../modules/")
		catch e
			IO.logError "The modules folder is missing!"
			throw "Missing the modules folder"
			return false
		@modules = []
		for moduleDir in data
			moduleDir = path.resolve "#{__dirname}/../../modules/#{moduleDir}"
			try
				moduleInfo = require "#{moduleDir}/config"
				moduleInfo.dir = moduleDir
				@modules.push moduleInfo
				IO.log "Loaded module '#{moduleInfo.name}' from '#{path.relative(path.resolve('./'),moduleDir)}'"
				try
					IO.log "Initialising module with namespace '../#{path.relative(path.resolve('./'),moduleDir)}/#{moduleInfo.namespace}'"
					@routes.push
						address: "/#{moduleInfo.namespace}/:controller?/:action?/:view?"
						method: 'get'
						callback: (req, res, template) ->
							mvcHelper.loadModule moduleInfo, req, template, res
							#IO.log "#{moduleInfo.namespace} Not yet Implemented"
					IO.log "Initialised module '#{moduleInfo.name}' with namespace '#{moduleInfo.namespace}'"
				catch e
					IO.logError "Failed to initialise '#{moduleInfo.name}' with namespace '#{moduleInfo.namespace}'"
					IO.debug e
			catch e
				IO.logError "Failed to load module from \"#{moduleDir}\""
				IO.debug e
		Router = require '../../coffeeblog/router'
		@setupStaticRoutes Router
		@setupRoutes Router.singleton()
		true

	setupStaticRoutes:(Router) =>
		for module in @modules
			##TODO: Make this part work... lol
			Router.singleton().app.use express.static "/#{module.name}", path.resolve "#{__dirname}/../../modules/#{module.name}/public"


module.exports = cb_modules
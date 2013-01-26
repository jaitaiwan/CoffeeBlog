###
# @name Helper.mvc
# @author Daniel J Holmes
# @description A helper function which helps plugins use MVC style urls in their route callbacks.
###

path = require 'path'
IO = require '../coffeeblog/log'
Q = require 'q'


## TODO Promises

class MVC
	loadModule: (info, request, response, template, next) ->
		promise = Q.fcall ->
			return true
		if info.template?
			TemplateHelper = require './Helper.template'
			template = TemplateHelper.loadTemplate info.template
			template = new template
			template.newContext()
		controller = if request.params.controller? then  request.params.controller else info.namespace
		Mod = require path.resolve "#{__dirname}/../modules/#{info.name}/#{controller}"
		view = request.params.view || 'default'
		Mod = new Mod view, template
		action = if request.params.action? then request.params.action else 'default'
		@initHelpers info.helperDependancies, request, response, template, promise
		if result = (Mod[action]?.call request.query)
			if typeof result is 'object'
				if result.redirect? then response.redirect result.redirect[0], result.redirect[1]
				true
		else
			next()
			false
		promise.fin ->
			#console.log arguments
			response.set template.headers
			response.send template.render()
			template.newContext()
			response.end()
			IO.log "Request Served"
		promise.fail ->
			IO.debug arguments
		promise.done()
		return true

	initHelpers: (dependancies, request, response, template, q) ->
		if dependancies? and dependancies.length > 0
			for dependant in dependancies
				try
					helper = require "./Helper.#{dependant}"
					if helper.initialise? then helper.initialise
						request: request
						response: response
						template: template
						promise: q
					IO.log "Loaded dependancy Helper.#{dependant}"
				catch e
					IO.warn "Unable to load dependancy Helper.#{dependant}"
					IO.debug e

module.exports = new MVC
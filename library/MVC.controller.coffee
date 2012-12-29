###
# @name MVC.controller
# @author Daniel J Holmes
# @description Provides a barebones module mvc controller to extend from
###

IO = require '../coffeeblog/log'
path = require 'path'

class controllerMVC
	constructor: (view, @template) ->
		if typeof view is 'string'
			try
				template.changeContent require "../#{path.relative './', path.dirname module.parent.id}/views/#{view}"
			catch e
				IO.log

	default: =>
		@template.context.title = "Not Yet Implemented"
		@template.changeContent require "../#{path.relative './', path.dirname module.parent.id}/views/error/404"
		true

	redirect: =>
		if arguments.length > 1
				redirect: arguments
		else
				redirect: [302,arguments[0]]

module.exports = controllerMVC
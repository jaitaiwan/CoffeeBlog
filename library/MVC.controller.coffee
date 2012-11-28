###
# @name MVC.controller
# @author Daniel J Holmes
# @description Provides a barebones module mvc controller to extend from
###

IO = require '../coffeeblog/log'

class controllerMVC
	constructor: (view, @template) ->
		if typeof view is 'string'
			try
				template.changeContent require "#{view}"
			catch e
				IO.log

	default: =>
		@template.context.title = "Not Yet Implemented"

module.exports = controllerMVC
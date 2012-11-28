###
# @name Helper.mvc
# @author Daniel J Holmes
# @description A helper function which helps plugins use MVC style urls in their route callbacks.
###

path = require 'path'

class MVC
	loadModule: (info, request, template, response) ->
		controller = if request.params.controller? then  request.params.controller else info.namespace
		Mod = require path.resolve "#{__dirname}/../modules/#{info.name}/#{controller}"
		Mod = new Mod request.params.view, template
		action = if request.params.action? then request.params.action else 'default'
		Mod[action].call request.query
		response.set template.headers
		response.send template.render()
		template.newContext()

module.exports = new MVC
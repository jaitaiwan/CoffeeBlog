###
# @name routes.coffee
# @author Daniel J Holmes
# @description Configures routes for cb-admin plugin
###
(->
	IO = require '../coffeeblog/log'
	Plugins = require '../coffeeblog/plugins'
	path = require 'path'

	return [
		{
			address: "/cb-debug/plugins/reinit"
			method: 'get'
			callback: (req, res, template) ->
				Plugins.singleton().reload()
				res.send "Success!"
		}
	]
)()
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
			address: "/cb-debug/reinit/plugins"
			method: 'get'
			callback: (req, res, template) ->
				Plugins.singleton().reload()
				res.send "Success!"
				IO.log "Request Served"
		}
		{
			address:"/cb-debug/reinit/template"
			method: 'get'
			callback: (req, res, template) ->
				coffeeblog = require '../coffeeblog/coffeeblog'
				Template = require '../coffeeblog/template'
				coffeeblog.singleton().template = new Template
				IO.log "Request Served"
		}
	]
)()
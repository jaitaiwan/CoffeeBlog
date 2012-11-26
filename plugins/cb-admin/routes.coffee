###
# @name routes.coffee
# @author Daniel J Holmes
# @description Configures routes for cb-admin plugin
###
module.exports = (->
	IO = require '../coffeeblog/log'
	Plugins = require('../coffeeblog/plugins')

	return [
		{
			address: "/plugins/cb-admin"
			method: 'get'
			callback: (req, res, template) ->
				res.send 200, template.render {title:"Hi there", content:"Not Yet Implemented"}
				IO.log "/plugins/cb-admin Not yet Implemented"
		}
		{
			address: "/plugins/reinit"
			method:"get"
			callback: (req, res, template) ->
				res.send 200, template.render {title:"Admin", content:"Re-Init Plugins..."}
				Plugins.reload()
		}
		{
			address: "/plugins/added"
			method:"get"
			callback: (req, res, template) ->
				res.send template.render {title:"admin", content:"success!"}
		}
	]
)()
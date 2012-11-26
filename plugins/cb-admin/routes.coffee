###
# @name routes.coffee
# @author Daniel J Holmes
# @description Configures routes for cb-admin plugin
###

IO = require '../../coffeeblog/log'

module.exports = [
	{
		address: "/plugins/cb-admin"
		method: 'get'
		callback: (req, res, template) ->
			res.send 200, template.render {title:"Hi there", content:"Not Yet Implemented"}
			IO.log "/plugins/cb-admin Not yet Implemented"
	}
]
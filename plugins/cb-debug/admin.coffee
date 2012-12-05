###
# @name admin.coffee
# @author Daniel J Holmes
# @description Entrypoint for the back-end admin plugin
###

Plugin = require '../../library/Plugin.main'

class Admin extends Plugin
	routes: "#{__dirname}/routes.coffee"



module.exports = Admin
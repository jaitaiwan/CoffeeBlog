###
# @name template.coffee
# @author Daniel J Holmes
# @description Main entrypoint for the coffeeblog template
###

Template = require '../../library/Template'
config = require '../../config'

class CoffeeTemplate extends Template
	@title: config.siteTitle
	@defaultTemplate: require './views/main'

module.exports = CoffeeTemplate
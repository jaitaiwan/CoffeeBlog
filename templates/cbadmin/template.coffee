###
# @name template.coffee
# @author Daniel J Holmes
# @description Main entrypoint for the coffeeblog template
###

Template = require '../../library/Template'

class CoffeeTemplate extends Template
	defaultTemplate: require './views/main'

	init: ->
		require('./functions').call @

module.exports = CoffeeTemplate
###
# @name Template.engine
# @author Daniel J Holmes
# @description Parent class for all template engines
###

class Engine
	compiler: null
	defaultTemplate: ""

	###
	# Comiles template and returns html
	# to send to the browser
	#
	# @param object The context in which the template is called
	# @param string Optional. The template source. Defaults uses this.defaultTemplate
	###
	compile: (context, template) ->
		@compiler.render template, context

module.exports = Engine
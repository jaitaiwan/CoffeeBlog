###
# @name Template.coffee
# @author Daniel J Holmes
# @description Basic template class with reusable functionality for templates
###

_ = require 'underscore'

class Template
	context: new require './Template.context'

	defaultTemplate: "
	<!DOCTYPE html>
	<html>
		<head>
			<title><%= @title %></title>
			<%- @head_scripts() %>
			<%- @head_styles() %>

		</head>
		<body>
			<%- @the_header() %>
			<%- @the_content() %>
			<%- @the_footer() %>
		</body>
	</html>
	"
	engine: new require './Template.engine.eco'

	addScript: (script, position = 'head', type = 'text/javascript') =>
		switch position
			when 'head' then @context.addHeadScript script, type
			when 'foot' then @context.addFootScript script, type


	addStyle: (location, rel = 'stylesheet', type = 'text/css') =>
		@context.addStyleSheet style, rel, type

	changeContent: (content) =>
		@context.changeContent content

	newContext: (@context) =>

	render: (data = {}, template = @defaultTemplate) =>
		@engine.compile _.extend(@context,data), template





module.exports = Template
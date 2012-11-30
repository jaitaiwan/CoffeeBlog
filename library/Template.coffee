###
# @name Template.coffee
# @author Daniel J Holmes
# @description Basic template class with reusable functionality for templates
###
IO = require '../coffeeblog/log'
_ = require 'underscore'
Context = require './Template.context'
Engine = require './Template.engine.eco'
class Template
	context: new Context

	headers:
		'Content-type':'text/html'

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
	engine: new Engine

	addScript: (script, position = 'head', type = 'text/javascript') =>
		switch position
			when 'head' then @context.addHeadScript script, type
			when 'foot' then @context.addFootScript script, type


	addStyle: (location, rel = 'stylesheet', type = 'text/css') =>
		@context.addStyleSheet style, rel, type

	changeContent: (content) =>
		@context.changeContent content

	newContext: (context) =>
		if not context? then @context = new Context

	render: (data = {}, template) =>
		template ?= @defaultTemplate
		if typeof template is 'function'
			return @renderView template, data
		@engine.compile (_.extend @context, data), template

	renderView: (template, data = {}) ->
		if typeof template isnt 'function' or typeof data isnt 'object' then return false
		_.extend @context, data
		template data





module.exports = Template
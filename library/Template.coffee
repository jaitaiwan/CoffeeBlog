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
	staticData:
		menus: []
		scripts:
			head: []
			foot: []
		styles: []

	engine: new Engine

	addScript: (script, position = 'head', type = 'text/javascript') =>
		switch position
			when 'head' then @addHeadScript script, type
			when 'foot' then @addFootScript script, type


	addStyle: (location, rel = 'stylesheet', type = 'text/css') =>
		@addStyleSheet location, rel, type

	changeContent: (content) =>
		if typeof content is 'function' then content = content()
		@context.changeContent content

	addHeadScript: (script, type) ->
		@staticData.scripts.head.push
			source: script
			type: type

	addFootScript: (script, type) ->
		@staticData.scripts.foot.push
			source: script
			type: type

	addStyleSheet: (href, rel, type) ->
		@staticData.styles.push
			source: href
			rel: rel
			type: type

	newContext: (context) =>
		if not context? then @context = new Context
		else @context = context

	render: (data = {}, template) =>
		template ?= @defaultTemplate
		if typeof template is 'function'
			return @renderView template, data
		@engine.compile (_.extend @staticData, @context, data), template

	renderView: (template, data = {}) ->
		if typeof template isnt 'function' or typeof data isnt 'object' then return false
		template _.extend @staticData, @context, data

	registerMenu: (menuName) =>
		coffeeblog = require '../coffeeblog/coffeeblog'
		Database = coffeeblog.singleton().database
		Database.get {menu:menuName}, {menuorder:2}, (err, data) =>
			if err then return false
			@staticData.menus[menuName] = data
		, "menus"

	init: ->


module.exports = Template
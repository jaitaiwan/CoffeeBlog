###
# @name Template.context
# @author Daniel J Holmes
# @description Provides helper functions for template contexts
###
IO = require '../coffeeblog/log'
config = require '../config'
path = require 'path'
class Context
	title: config.siteTitle
	headers:
		'Content-type':'text/html'

	header: ""
	footer: ""
	content: ""

	the_header: (context) ->
		try
			view = require path.resolve "#{__dirname}/../templates/#{config.template}/views/header"
			view context
		catch e
			IO.debug e
			@header
	the_footer: (context) ->
		try
			view = require path.resolve "#{__dirname}/../templates/#{config.template}/views/footer"
			view context
		catch e
			IO.debug e
			@footer + @foot_scripts()
	the_content: ->
		@content

	head_scripts: ->
		scripts = ""
		scripts += "<script type='#{script.type}' src='#{script.source}'></script>" for script in @scripts.head
		scripts

	foot_scripts: -> 
		scripts = ""
		scripts += "<script type='#{script.type}' src='#{script.source}'></script>" for script in @scripts.foot
		scripts

	head_styles: ->
		styles = ""
		styles += "<link type='#{style.type}' rel='#{style.rel}' href='#{style.source}'></script>" for style in @styles
		styles

	changeContent: (@content) ->

	cb_menu: (menuName) ->
		@menus[menuName] if @menus?[menuName]?

module.exports = Context
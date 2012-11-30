###
# @name Template.context
# @author Daniel J Holmes
# @description Provides helper functions for template contexts
###
IO = require '../coffeeblog/log'
config = require '../config'
path = require 'path'
class Context
	scripts:
		head: []
		foot: []

	styles:[]


	title: "Default Template"

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
	the_footer: ->
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
		styles += "<link type='#{style.type}' rel='#{style.rel}' href='#{style.source}'></script>" for style in styles
		styles

	addHeadScript: (script, type) ->
		@scripts.head.push
			source: script
			type: type

	addFootScript: (script, type) ->
		@scripts.foot.push
			source: script
			type: type

	addStyleSheet: (href, rel, type) ->
		@styles.push
			source: href
			rel: rel
			type: type

	changeContent: (@content) ->

module.exports = Context
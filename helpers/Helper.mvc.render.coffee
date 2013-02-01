###
# @name Helper.mvc.render
# @author 
# @description Provides a framework to make sure that headers are sent before body.
###


coffeeblog = require("../coffeeblog/coffeeblog").singleton()
IO = require "../coffeeblog/log"
Database = coffeeblog.database
ObjectID = require('mongojs').ObjectId
Q = require 'q'

class RenderMVCHelper
	instance = null
	promise: Q.fcall ->
		return true

	body: []

	headers: []

	@initialise: (data) ->
		@::request = data.request
		@::response = data.response
		@singleton

	@singleton: ->
		instance ?= new RenderMVCHelper
		instance

	thenHeader: (fn) ->
		if not Q.isPromise fn then fn = Q.when true, fn
		@headers.push fn

	thenBody: (fn) ->
		@body.push fn

	done: ->
		console.log @headers, @body
		Q.fcall(@headers).fin => Q.when true, @_resolve

	_resolve: =>
		res = Q.resolve true
		@body.forEach (f) ->
			res = res.then f
		@headers = []
		@body = []






module.exports = RenderMVCHelper
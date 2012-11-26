###
# @name router.coffee
# @author Daniel J Holmes
# @description A class which takes over routing control from express so we can lazy-load routes without restarting the server
###

Route = require 'express/lib/router/route'
IO = require './log'

class Router
	routes:
		get:[]
		put:[]
		post:[]
		del:[]

	instance = null
	@singleton: ->
		instance ?= new Router
		instance

	initialise: (app, @template) ->
		app.get '*', @getRoute
		app.put '*', @putRoute
		app.post '*', @postRoute
		app.delete '*', @delRoute

	getRoute: (req, res, next) =>
		for route in @routes.get
			if route.match req.path
				req.params = route.params
				route.callbacks req, res, @template
				return true
				break
		@send404 res


	putRoute: (req, res, next) =>
		for route in @routes.put
			if route.match req.path
				req.params = route.params
				route.callbacks req, res, @template
				return true
				break
		@send404 res

	postRoute: (req, res, next) =>
		for route in @routes.post
			if route.match req.path
				req.params = route.params
				route.callbacks req, res, @template
				return true
				break
		@send404 res

	delRoute: (req, res, next) =>
		for route in @routes.del
			if route.match req.path
				req.params = route.params
				route.callbacks req, res, @template
				return true
				break
		@send404 res

	addRoute: (method, location, callback) ->
		for route in @routes[method] then if location is route.path and callback is route.callbacks then return false
		IO.log "Adding route; Method: #{method}, Location: #{location}"
		@routes[method].push new Route method, location, callback

	send404: (res)->
		@template.changeContent "Sorry, I couldn't find that page!"
		res.send 404, @template.render {title:'Error 404'}

module.exports = Router.singleton()
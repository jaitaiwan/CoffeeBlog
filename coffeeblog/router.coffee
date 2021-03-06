###
# @name router.coffee
# @author Daniel J Holmes
# @description A class which takes over routing control from express so we can lazy-load routes without restarting the server
###

Route = require 'express/lib/router/route'
IO = require './log'
Context = require '../library/Template.context'
express = require 'express'
benchmark = require('../helpers/Helper.benchmark').singleton()
class Router
	routes:
		get:[]
		put:[]
		post:[]
		del:[]

	staticRoutes: []

	instance = null
	@singleton: ->
		instance ?= new Router
		instance

	initialise: (@app, @template) ->
		app.use route.location, express.static route.path for route in @staticRoutes
		app.get '*', @getRoute
		app.put '*', @putRoute
		app.post '*', @postRoute
		app.delete '*', @delRoute
		app.use app.router

	getRoute: (req, res) =>
		IO.log "Client requested #{req.path} with method 'get'"
		middleware = []
		for route in @routes.get
			if route.match req.path
				console.log route.path
				req.params = route.params
				middleware.push route.callbacks
		i = -1
		next = =>
			i++
			if middleware[i]?
				middleware[i] req, res, @template, next
			else if middleware.length isnt 0
				console.log "Middleware beta"
				@send404 res
				false
			else
				console.log middleware.length, middleware[i]
		next()
		if middleware.length is 0
			console.log "Middleware alpha"
			@send404 res



	putRoute: (req, res, next) =>
		IO.log "Client requested #{req.path} with method 'put'"
		middleware = []
		for route in @routes.put
			if route.match req.path
				req.params = route.params
				middleware.push route.callbacks
		i = -1
		next = =>
			i++
			if middleware[i]?
				middleware[i] req, res, @template, next
			else
				@send404 res
				false
		next()
		if middleware.length is 0
			@send404 res

	postRoute: (req, res, next) =>
		IO.log "Client requested #{req.path} with method 'post'"
		middleware = []
		for route in @routes.post
			if route.match req.path
				req.params = route.params
				middleware.push route.callbacks
		i = -1
		next = =>
			i++
			if middleware[i]?
				middleware[i] req, res, @template, next
			else
				@send404 res
				false
		next()
		if middleware.length is 0
			@send404 res

	delRoute: (req, res, next) =>
		IO.log "Client requested #{req.path} with method 'del'"
		middleware = []
		for route in @routes.del
			if route.match req.path
				req.params = route.params
				middleware.push route.callbacks
		i = -1
		next = =>
			i++
			if middleware[i]?
				middleware[i] req, res, @template, next
			else
				@send404 res
				false
		next()
		if middleware.length is 0
			@send404 res

	addRoute: (method, location, callback) ->
		if @routes[method]?.length > 0 then for route in @routes[method] then if location is route.path and callback is route.callbacks then return false
		IO.log "Adding route; Method: #{method}, Location: #{location}"
		@routes[method].push new Route method, location, callback

	reset: ->
		@routes = 
			get:[]
			put:[]
			del:[]
			post:[]
		@staticRoutes = []

	addStaticRoute: (identifier, physicalLocation) =>
		@staticRoutes.push 
			location:identifier
			path:physicalLocation

	send404: (res) =>
		IO.log "404 Request not served"
		res.set @template.headers
		@template.changeContent "Sorry, I couldn't find that page!"
		data = @template.render {title:'Error 404'}

		res.status(404).write(data)
		res.end()  ## <- Somethin's going on here!
		@template.newContext()

module.exports = Router
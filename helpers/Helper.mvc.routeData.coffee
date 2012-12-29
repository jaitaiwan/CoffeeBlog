###
# @name Helper.mvc.requestHelper
# @author Daniel J Holmes
# @description Abstracts access to the request object returned from express and provides useful functions
###

IO = require '../coffeeblog/log'

class RouteDataHelper
	instance = null

	@initialise: (data) ->
		@request = data.request
		@response = data.response
		@singleton()

	@singleton: ->
		if not @request?
			IO.error "RequestHelper must be initialised with a request!"
		instance ?= new RouteDataHelper
		instance

	setCookie: (name, value) ->
		@response.cookie name, value

	getCookie: (name) ->
		return @request.cookies[name]
		



module.exports = RouteDataHelper
###
# @name Helper.auth
# @author Daniel J Holmes
# @description Provides authorisation helpers for modules & plugins
###

Database = require("../coffeeblog/coffeeblog").database
IO = require "../coffeeblog/log"

class AuthHelper
	instance = null

	@initialise: (data) ->
		@request = data.request
		@response = data.response
		@singleton

	@singleton: ->
		instance ?= new AuthHelper
		instance

	# Taken From http://stackoverflow.com/questions/105034/how-to-create-a-guid-uuid-in-javascript
	# Re-jigged into coffee sweetness by Dan H.
	createUID: ->
		d = new Date().getTime()
		uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace /[xy]/g, (c) ->
			r = (d + Math.random() * 16) % 16 | 0
			d = Math.floor d / 16
			(if c is 'x' then r else (r & 0x7 | 0x8)).toString 16
		uuid

	sendUID: ->
		uuid = @createUID()
		Database.set null,
			uuid: uuid
			sessionID: @request.session
		, (err) =>
			if err
				IO.warn "Failed to set UUID in database"
				IO.debug err
				return false
			@response.cookie 'uuid', uuid
		, false, "sessions"

		uuid

	isAuthorised: ->
		currentSession = @request.session
		if not currentUUID = @request.cookies.uuid
			IO.warn "Valid session but no UUID set"
			return false;
		Database.get {sessionID: currentSession, uuid: currentUUID}, {}, (err, data) =>
			if err
				IO.warn "Failed to get a valid session"
				IO.debug err
				@response.send 401, "Application not authorised"
				return false;
		, "sessions"

	## TODO ##
	getUser: (fn) ->

	setUser: (username, password) ->


module.exports = AuthHelper
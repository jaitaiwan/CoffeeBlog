###
# @name Helper.auth
# @author Daniel J Holmes
# @description Provides authorisation helpers for modules & plugins
###

Database = require("../coffeeblog/coffeeblog").database
IO = require "../coffeeblog/log"
ObjectID = require('mongojs').ObjectId

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

	sendUID: (errLoc) ->
		uuid = @createUID()
		Database.set null,
			uuid: uuid
			sessionID: @request.session
		, (err) =>
			if err
				IO.warn "Failed to set UUID in database"
				IO.debug err
				@response.redirect errLoc
				return false
			@response.cookie 'uuid', uuid
		, false, "sessions"

		uuid

	isAuthorised: (fn)->
		currentSession = @request.session
		fn ?= (err, data) =>
			if err
				IO.warn "Failed to get a valid session"
				IO.debug err
				@response.send 401, "Application not authorised"
				return false
		if not currentUUID = @request.cookies.uuid
			IO.warn "Valid session but no UUID set"
			return false
		Database.get {sessionID: currentSession, uuid: currentUUID}, {}, fn, "sessions"

	getUser: (fn) ->
		if typeof fn isnt "function"
			IO.error "getUser needs a function"
		@isAuthorised (err, data) ->
			if err
				IO.warn "Couldn't get a valid session"
				IO.debug err
				return false
			if not data.uid
				IO.warn "No user is logged in with this session"
				IO.debug data
				return false
			Database.get {_id:ObjectID(data.uid)}, {}, fn, "users"

	setUser: (username, password, fn) ->
		Database.get {username:username,password:password}, {}, (err, data) ->
			if err
				IO.warn "Something went wrong"
				fn err, data
				return false
			if data.length is 0
				fn err, data
			else
				IO.warn "Data.length wrong"
		, "Users"

module.exports = AuthHelper
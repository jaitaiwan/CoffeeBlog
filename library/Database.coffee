###
# @name Database
# @author Daniel J Holmes
# @description Skeleton class for Database engines to wrap around
###

IO = require '../coffeeblog/log'

class Database
	engine: ->

	start: ->
		dsn = if @user isnt '' and @auth is true then "#{@user}:#{@password}@#{@host}/#{@db}" else "#{@host}/#{@db}"
		@handle = @engine dsn
		IO.log "Connected to database #{dsn}"
		
	get: (findObj, orderBy = {}, fn, collection) ->
		if typeof arguments[arguments.length -2] isnt 'function' then return false

	set: (findObj, setObj, fn, setAll = false, collection) ->
		if typeof arguments[arguments.length -3] isnt 'function' then return false

module.exports = Database
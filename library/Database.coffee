###
# @name Database
# @author Daniel J Holmes
# @description Skeleton class for Database engines to wrap around
###

class Database
	engine: ->
	db: 'coffeeblog'
	user: 'coffeeuser'
	password:''
	collections: ['']

	constructor: ->
		@handle = @engine @db, @collections
		@defaultCollection = @collections[0]

	get: (findObj, orderBy = {}, fn, collection) ->
		if typeof arguments[arguments.length -2] isnt 'function' then return false
		col = if collection? then collection else @defaultCollection

	set: (findObj, setObj, fn, setAll = false, collection) ->
		if typeof arguments[arguments.length -3] isnt 'function' then return false
		col = if collection? then collection else @defaultCollection

module.exports = Database
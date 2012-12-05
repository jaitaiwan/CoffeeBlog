###
# @name Database
# @author Daniel J Holmes
# @description Skeleton class for Database engines to wrap around
###

MongoDB = require 'mongojs'
Database = require './Database'
config = require '../config'

class Database.Mongo extends Database
	engine: MongoDB
	host: config.db.host
	db: config.db.db
	user: config.db.user
	password: config.db.password
	auth: false

	get: (findObj, orderBy = {}, fn, collection) ->
		if typeof arguments[arguments.length - 2] isnt 'function' then return false
		col = @handle.collection collection
		col.find 
			$query: findObj
			$orderby: orderBy
		, fn

	set: (findObj, setObj, fn, setAll = false, collection) ->
		if typeof arguments[arguments.length -3] isnt 'function' then return false
		@handle[collection].update findObj, {$set:setObj}, {multi:setAll}, fn

module.exports = Database.Mongo
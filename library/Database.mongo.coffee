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
	user: config.db.username
	password: config.db.password
	auth: config.db.auth

	get: (findObj, orderBy = {}, fn, collection) ->
		if typeof arguments[arguments.length - 2] isnt 'function' then return false
		col = @handle.collection collection
		col.find 
			$query: findObj
			$orderby: orderBy
		, fn

	set: (findObj, setObj, fn, setAll = false, collection) ->
		col = @handle.collection collection
		if typeof arguments[arguments.length - 3] isnt 'function' then return false
		if not findObj? then col.save setObj, fn
		else col.update findObj, {$set:setObj}, {multi:setAll}, fn

	ensureIndex: (index, collection) ->
		col = @handle.collection collection
		col.ensureIndex index

module.exports = Database.Mongo
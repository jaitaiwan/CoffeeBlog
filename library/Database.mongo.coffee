###
# @name Database
# @author Daniel J Holmes
# @description Skeleton class for Database engines to wrap around
###

MongoDB = require 'mongojs'
Database = require './Database'

class Database.Mongo extends Database
	engine: MongoDB

	contructor: (db, user, password, collections) ->
		@db = db if db? and typeof db is 'string'
		@user = user if user? and typeof user is 'string'
		@password = password if password? and typeof password is 'string'
		@collections = collections if collections? and typeof collections is 'array'
		super

	get: (findObj, orderBy = {}, fn, collection) ->
		if typeof arguments[arguments.length -2] isnt 'function' then return false
		col = if collection? then collection else @defaultCollection
		@handle[col].find 
			$query: findObj
			$orderby: orderBy
		, fn

	set: (findObj, setObj, fn, setAll = false, collection) ->
		if typeof arguments[arguments.length -3] isnt 'function' then return false
		col = if collection? then collection else @defaultCollection
		@handle[col].update findObj, {$set:setObj}, {multi:setAll}, fn

	addCollection: (collection) ->
		for item in collection
			if item is collection then return false
		@collections.push collection
		db.collection @collections

module.exports = Database.Mongo
###
# @name Database
# @author Daniel J Holmes
# @Description selects the appropriate database driver based on config.
###

config = require '../config'
IO = require './log'

try
	Database = require "../library/Database.#{config.db.engine.toLowerCase()}"
	module.exports = Database
catch e
	IO.logError "Failed to load the database with engine: #{config.db.engine}"
	IO.debug e
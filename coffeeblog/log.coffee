###
# @name log.coffee
# @author Daniel J Holmes
# @description Simple IO log
###

util = require 'util'

class Log
		@log: (message) ->
			util.log "#{message}"

		@logError: (message) ->
			util.error "ERROR: #{message}"

		@debug: (element) ->
			e = if element.message? then element else util.inspect element, true
			util.print "DEBUG: #{e.stack}\n#{e.message}\n"

module.exports = Log
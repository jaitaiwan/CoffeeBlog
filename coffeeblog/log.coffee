###
# @name log.coffee
# @author Daniel J Holmes
# @description Simple IO log
###

util = require 'util'
config = require '../config'

class Log
		@log: (message) ->
			util.log "#{message}" if config.errorLevel >= 0

		@logError: (message) ->
			util.error "ERROR: #{message}" if config.errorLevel >= 1

		@debug: (element) ->
			e = if element.message? then "DEBUG: #{element.stack}\n#{element.message}\n" else util.inspect element, true
			util.print e if config.errorLevel >= 2

module.exports = Log
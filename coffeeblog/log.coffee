###
# @name log.coffee
# @author Daniel J Holmes
# @description Simple IO log
###

util = require 'util'
config = require '../config'

class Log
		@log: (message) ->
			util.log "\x1B[34m#{message}\x1B[0m" if config.errorLevel >= 0

		@error: (message) ->
			util.error "\x1B[31m\x1B[1m\x1b[7m ERROR \x1B[0m\x1B[31m #{message}\x1B[0m \x1B[31m\x1B[1m\x1b[7m ERROR \x1B[0m" if config.errorLevel >= 1

		@warn: (message) ->
			util.error "\x1B[33m\x1B[1m\x1b[7m WARN \x1B[0m\x1B[33m #{message}\x1B[0m \x1B[33m\x1B[1m\x1b[7m WARN \x1B[0m" if config.errorLevel >= 2

		@debug: (element) ->
			e = if element.message? then "DEBUG:\n#{element.stack}\n" else util.inspect element, true
			util.print "\x1B[32m#{e}\x1B[0m" if config.errorLevel >= 3

		@custom: (message) ->
			util.print message

module.exports = Log
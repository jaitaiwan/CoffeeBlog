###
# @name template.coffee
# @author Daniel J Holmes
# @description Loads template based on config
###

IO = require './log'
config = require "../config"
fs = require 'fs'
path = require 'path'

expo = null

try
	fs.readdirSync path.resolve "#{__dirname}/../templates/"
	try
		fs.readdirSync path.resolve "#{__dirname}/../templates/#{config.template}"
		try
			templateConfig = require path.resolve "#{__dirname}/../templates/#{config.template}/config"
			try
				expo = require path.resolve "#{__dirname}/../templates/#{config.template}/#{templateConfig.entrypoint}"
			catch e
				IO.logError "Failed to load template"
				IO.debug e
			
		catch e
			IO.logError "Template has no config!"
	catch e
		IO.logError "The template: #{config.template} cannot be found."
catch e
	IO.logError "The templates folder is missing!"


module.exports = expo
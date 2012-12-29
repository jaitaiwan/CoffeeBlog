###
# @name Helper.template
# @author Daniel J Holmes
# @description Contains widely used functions for everything templatey
###

fs = require 'fs'
path = require 'path'
IO = '../coffeeblog/log'

class TemplateHelper
	@loadTemplate: (template) ->
		expo = null
		try
			fs.readdirSync path.resolve "#{__dirname}/../templates/"
			try
				fs.readdirSync path.resolve "#{__dirname}/../templates/#{template}"
				try
					templateConfig = require path.resolve "#{__dirname}/../templates/#{template}/config"
					try
						expo = require path.resolve "#{__dirname}/../templates/#{template}/#{templateConfig.entrypoint}"
					catch e
						IO.error "Failed to load template"
						IO.debug e
					
				catch e
					IO.error "Template has no config!"
			catch e
				IO.error "The template: #{config.template} cannot be found."
		catch e
			IO.logError "The templates folder is missing!"

		expo


module.exports = TemplateHelper
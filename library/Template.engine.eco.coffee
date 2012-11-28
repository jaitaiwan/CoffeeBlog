###
# @name template.engine.eco.coffee
# @author Daniel J Holmes
# @description sets up an eco template engine
###

Engine = require './Template.engine'
engine = require 'eco'

class Eco extends Engine
	compiler: engine


module.exports = Eco
###
# @name template.coffee
# @author Daniel J Holmes
# @description Loads template based on config
###

config = require "../config"
TemplateHelper = require '../helpers/Helper.template'
module.exports = TemplateHelper.loadTemplate config.template
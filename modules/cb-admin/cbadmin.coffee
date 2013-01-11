###
# @name cbadmin
# @author Daniel J Holmes
# @description The default controller for the cbadmin module
###

ControllerMVC = require '../../library/MVC.controller'
RequestHelper = require '../../helpers/Helper.mvc.routeData'
AuthHelper = require '../../helpers/Helper.auth'


class cbadmin extends ControllerMVC

	default: ->
		ah = AuthHelper.singleton()
		ah.sendUID()
		@template.title = ""
		return true

	doSomething: ->
		ah = AuthHelper.singleton()
		ah.isAuthorised()

module.exports = cbadmin
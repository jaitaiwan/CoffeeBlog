###
# @name cb-pages
# @author Daniel J Holmes
# @description loads pages based on url
###

Plugin = require '../../library/Plugin.main'
IO = require '../../coffeeblog/log'
coffeeblog = require '../../coffeeblog/coffeeblog'
Database = coffeeblog.singleton().database
config = require '../../config'

class Pages extends Plugin
	routes:[
		{
			address: '/:page'
			method: 'get'
			callback: (request, response, template, next) =>
				Database.get {postType:"page"}, {}, (err, datas) ->
					for data in datas
						if data.name is request.params.page
							try
								view = require "../../templates/#{config.template}/views/page"
								template.changeContent view data
							catch e
								IO.warn "Template does not have a page view"
								IO.debug e
								template.changeContent data.contents
							response.send template.render()
							template.newContext()
							true
						else next()
				, "posts"
		}
	]

module.exports = Pages
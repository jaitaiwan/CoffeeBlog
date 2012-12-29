module.exports = 
	port: 8080
	template:"coffeeblog"
	siteTitle: "CoffeeBlog"
	###
	# Error Level (used by log.coffee)
	# 0 = Log only
	# 1 = Log & Errors
	# 2 = Log, Errors & Warn
	# 3 = Log, Errors, Warn & Debug
	###
	errorLevel: 3
	db:
		engine: 'Mongo'
		host: 'localhost'
		user: 'coffeeuser'
		db:'coffeeblog'
		auth: false
		password: '1amaw3s0me'
		collections: ['users','posts','config']

cookie:
	secret: 'aw3someAsBr0'
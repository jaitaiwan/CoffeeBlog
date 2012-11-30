module.exports = 
	port: 8080
	template:"coffeeblog"
	###
	# Error Level (used by log.coffee)
	# 0 = Log only
	# 1 = Log & Errors
	# 2 = Log, Errors and Debug
	###
	errorLevel: 3
	db:
		engine: 'Mongo'
		user: 'coffeeblog'
		password: '1amaw3s0me'
		collections: ['users','posts']
IO = require '../../coffeeblog/log'

module.exports = [
	{
		address: "/plugins/cb-admin"
		method: 'get'
		callback: (req, res, next) ->
			res.send "Not Yet Implemented"
			IO.log "/plugins/cb-admin Not yet Implemented"
	}
]
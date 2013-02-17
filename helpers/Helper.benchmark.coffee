###
# @name Helper.benchmark
# @author Daniel J Holmes
# @description A simple helper to detail the page runs
###

IO = require '../coffeeblog/log'

class BenchmarkHelper
	instance = null

	@initialise: (data) ->
		@singleton

	@singleton: ->
		instance ?= new BenchmarkHelper
		instance

	getDate: ->
		new Date()

	start: =>
		@time = @getDate().getTime()
		IO.custom "\x1B[32m\x1B[1m\x1b[7mBENCHMARK\x1B[0m Benchmark started at #{@time}\n"

	lap: (index) =>
		@laps ?= []
		if not @time then @start()
		@laps[index] ?= []
		@laps[index].push @getDate().getTime()
		IO.custom "\x1B[32m\x1B[1m\x1b[7mBENCHMARK\x1B[0m Lap #{@laps[index].length}. Time since last lap of '#{index}' is #{@timeSinceIndex(index, @laps[index].length - 2)}ms\n"

	timeSinceIndex: (index, lap = 0) =>
		@laps ?= []
		if @laps[index][lap]?
			@getDate().getTime() - @laps[index][lap]
		else
			0

	logTimeSinceIndex: (index) =>
		if @laps[index]
			IO.custom "\x1B[32m\x1B[1m\x1b[7mBENCHMARK\x1B[0m It has been #{@getDate().getTime() - @laps[index][0]}ms since start of #{index}\n"
		else
			IO.warn "No lap under index #{index}"


	logTimeSinceStart: =>
		IO.custom "\x1B[32m\x1B[1m\x1b[7mBENCHMARK\x1B[0m It has been #{@getDate().getTime() - @time}ms since start\n"

	complete: (index) =>
		IO.log "Completing request #{index}"
		@laps ?= []
		if not @time then @start()
		@laps[index] ?= []
		@laps[index].push @getDate().getTime()
		IO.custom "\x1B[32m\x1B[1m\x1b[7mBENCHMARK\x1B[0m Race '#{index}' over.\n    Laps: #{@laps[index].length}\n    Time since last lap: #{@timeSinceIndex(index, @laps[index].length - 2)}ms\n    Total time: #{@laps[index][@laps[index].length - 1] - @laps[index][0]}ms\n\n"
		@laps[index] = null


	dumpBenchmark: =>


module.exports = BenchmarkHelper
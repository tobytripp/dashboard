#= require cell
$ = undefined

Timer = ->
Timer::interval = (ms, callback) ->
  @id = window.setInterval callback, ms
Timer::once = (ms, callback) ->
  @id = window.setTimeout callback, ms
Timer::stop = () ->
  window.clearInterval @id

class Dashboard.Grid extends Backbone.Collection
  model: Dashboard.Cell

  initialize: (cells, options) ->
    options ?= {}
    @timer = options.timer
    @timer ?= new Timer()
    @timer.interval 500, => @rotate()

    @last_rotated_index = -1

  rotate: () ->
    @last_rotated_index = (@last_rotated_index + 1) % @length
    @at( @last_rotated_index ).flip()

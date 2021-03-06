#= require cell
#= require timer
$ = undefined

class Dashboard.Grid extends Backbone.Collection
  model: Dashboard.Cell
  # localStorage: new Backbone.LocalStorage( "Grid" )

  initialize: (cells, options) ->
    options ?= {}
    @timer   = options.timer
    @timer  ?= new Timer()
    @timer.interval 3000, => @rotate()

    @last_rotated_index = -1
    @row_count    = 2
    @column_count = 3

  rotate: () ->
    @last_rotated_index = (@last_rotated_index + 1) % @length
    @at( @last_rotated_index ).flip()

  columnWidth: () ->
    100.0 / @columns()

  rowHeight: () ->
    100.0 / @rows()

  rows: (n) ->
    if n?
      @row_count = n
      @each (cell) => cell.set "height", @rowHeight()
    @row_count

  columns: (n) ->
    if n?
      @column_count = n
      @each (cell) => cell.set "width", @columnWidth()
    @column_count

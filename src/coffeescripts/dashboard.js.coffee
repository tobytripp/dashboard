#= require_tree .
window.Dashboard ?= {}

$ = window.jQuery
class Dashboard.Controller
  constructor: (el, @options) ->
    @el = $ el
    @cells = []
    @el.find( "[href]" ).each (i, el) =>
      if i % 2 == 0
        @cells.push new Dashboard.Cell()
      _(@cells).last().addUrl $(el).attr( "href" )
    @el.empty()

  render: ->
    @grid = new Dashboard.Grid
    @view = new Dashboard.GridView model: @grid, columns: 3

    @grid.add @cells
    @grid.columns 3
    @grid.rows 2

    $("[role=main]").append @view.render().el
    @

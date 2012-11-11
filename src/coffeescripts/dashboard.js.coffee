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

  render: ->
    @cells = _.map [
        ["frames/1.html", "frames/2.html"],
        ["frames/3.html", "frames/4.html"],
        ["frames/5.html", "frames/6.html"],
        ["frames/1.html", "frames/2.html"],
        ["frames/3.html", "frames/4.html"],
        ["frames/5.html", "frames/6.html"],
      ], (hrefs) ->
        cell = new Dashboard.Cell()
        cell.add new Dashboard.Frame( url: hrefs[0] )
        cell.add new Dashboard.Frame( url: hrefs[1] )
        cell

    @grid = new Dashboard.Grid
    @view = new Dashboard.GridView model: @grid, columns: 3

    @grid.add @cells
    @grid.columns 3
    @grid.rows 2

    $("[role=main]").append @view.render().el
    @

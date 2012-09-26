#= require_tree .
window.Dashboard ?= {}

$ = window.jQuery
class Dashboard.Controller
  constructor: (@options) ->

  render: ->
    @cell0 = new Dashboard.Cell()
    @cell0.add new Dashboard.Frame( url: "frames/1.html" )
    @cell0.add new Dashboard.Frame( url: "frames/2.html" )

    @cell1 = new Dashboard.Cell()
    @cell1.add new Dashboard.Frame( url: "frames/3.html" )
    @cell1.add new Dashboard.Frame( url: "frames/4.html" )

    @cell2 = new Dashboard.Cell()
    @cell2.add new Dashboard.Frame( url: "frames/5.html" )
    @cell2.add new Dashboard.Frame( url: "frames/6.html" )

    @cell3 = new Dashboard.Cell()
    @cell3.add new Dashboard.Frame( url: "frames/1.html" )
    @cell3.add new Dashboard.Frame( url: "frames/2.html" )

    @cell4 = new Dashboard.Cell()
    @cell4.add new Dashboard.Frame( url: "frames/3.html" )
    @cell4.add new Dashboard.Frame( url: "frames/4.html" )

    @cell5 = new Dashboard.Cell()
    @cell5.add new Dashboard.Frame( url: "frames/5.html" )
    @cell5.add new Dashboard.Frame( url: "frames/6.html" )

    @grid = new Dashboard.Grid
    @view = new Dashboard.GridView model: @grid, columns: 3

    @grid.add [@cell0, @cell1, @cell2, @cell3, @cell4, @cell5]

    $("[role=main]").append @view.render().el
    @

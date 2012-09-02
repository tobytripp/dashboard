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
    @cell1.add new Dashboard.Frame( url: "http://coffeescript.org" )
    @cell1.add new Dashboard.Frame( url: "http://backbonejs.org" )

    @cell2 = new Dashboard.Cell()
    @cell2.add new Dashboard.Frame( url: "http://pivotal.github.com/jasmine/" )
    @cell2.add new Dashboard.Frame( url: "http://emacsformacosx.com" )

    @grid = new Dashboard.Grid
    @view = new Dashboard.GridView model: @grid

    @grid.add [@cell0, @cell1, @cell2]

    $("[role=main]").append @view.render().el
    @

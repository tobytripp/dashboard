#= require_tree .
window.Dashboard ?= {}

$ = window.jQuery
class Dashboard.Controller
  constructor: (@options) ->

  render: ->
    @cell1 = new Dashboard.Cell()
    @cell1.add new Dashboard.Frame( url: "http://coffeescript.org" )
    @cell1.add new Dashboard.Frame( url: "http://backbonejs.org" )

    @cell2 = new Dashboard.Cell()
    @cell2.add new Dashboard.Frame( url: "http://pivotal.github.com/jasmine/" )
    @cell2.add new Dashboard.Frame( url: "http://emacsformacosx.com" )

    @grid = new Dashboard.Grid
    @view = new Dashboard.GridView model: @grid

    @grid.add [@cell1, @cell2]

    $("[role=main]").append @view.render().el
    @

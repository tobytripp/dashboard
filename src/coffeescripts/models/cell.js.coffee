#= require frame

$ = undefined
window.Dashboard ?= {}

class Dashboard.Cell extends Backbone.Collection
  model: Dashboard.Frame

  flip: ->
    @each (frame) -> frame.flip()

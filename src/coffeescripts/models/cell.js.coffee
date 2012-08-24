window.Dashboard ?= {}
class Dashboard.Cell extends Backbone.Model
  defaults:
    column_span:  1
    refresh_rate: undefined

  initialize: (front, back) ->

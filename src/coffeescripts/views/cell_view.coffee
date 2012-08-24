$ = jQuery
jQuery ->
  class CellView extends Backbone.View
    initialize: ->
      _.bindAll @
      @render()

    render: ->
      @
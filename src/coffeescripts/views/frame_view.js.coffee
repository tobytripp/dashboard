$ = jQuery
class Dashboard.FrameView extends Backbone.View
  tagname: 'iframe'

  initialize: ->
    _.bindAll @
    @model.on "change", @render, this

  render: ->
    @

  attributes: ->
    src: @model.get( "url" )

$ = jQuery
class Dashboard.FrameView extends Backbone.View
  tagname:   'div'
  className: 'frame'

  initialize: ->
    _.bindAll @
    @model.on "change", @render
    @frame = $("<iframe seamless></iframe>")
    @$el.append @frame
    @render()

  render: ->
    @frame.attr "name", @model.get( "url" )
    @frame.attr "scrolling", "no"
    @frame.attr "src",  @model.get( "url" )
    @setFace()
    @

  setFace: ->
    @$el.toggleClass "front", @model.front()
    @$el.toggleClass "back", !@model.front()

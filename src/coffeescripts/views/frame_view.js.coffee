$ = jQuery
class Dashboard.FrameView extends Backbone.View
  tagname:   'div'
  className: 'frame'

  initialize: ->
    _.bindAll @
    @model.on "change", this.render
    @frame = $("<iframe/>")
    @$el.append @frame
    @render()

  render: ->
    @frame.attr "src", @model.get( "url" )
    @setFace()
    @

  setFace: ->
    console.log "setFace front: ", @model.front()
    @$el.toggleClass "front", @model.front()
    @$el.toggleClass "back", !@model.front()

$ = jQuery
class Dashboard.FrameView extends Backbone.View
  tagname: 'iframe'

  initialize: ->
    _.bindAll @
    @model.on "change", this.render

  render: ->
    @$el.attr "src", @model.get( "url" )
    @

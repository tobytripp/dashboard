$ = jQuery
window.Dashboard ?= {}
class Dashboard.CellView extends Backbone.View
  tagname:   "div"
  className: "cell"

  initialize: ->
    _.bindAll @
    @model.on 'add',   @addFrame
    @model.on 'reset', @addAllFrame
    @model.on 'all',   @render
    @render()

  render: ->
    @

  addFrame: (frame) ->
    view = new Dashboard.FrameView( model: frame )
    this.$el.append view.render().el

  addAllFrames: ->
    @model.each @addFrame

  flip: ->
    @model.flip()

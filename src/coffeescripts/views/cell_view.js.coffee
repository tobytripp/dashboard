$ = jQuery
class Dashboard.CellView extends Backbone.View
  tagname:   "div"
  className: "cell"

  initialize: ->
    _.bindAll @
    @model.on 'cell:add', @addFrame
    @model.on 'all', @render
    @render()
    @addAllFrames()

  render: ->
    this.$el.toggleClass 'back', @model.backFacing()
    # this.$el.height @model.get( "height" ) + "%"
    # this.$el.width  @model.get( "width" )  + "%"
    @

  addFrame: (frame, inCell) ->
    view = new Dashboard.FrameView( model: frame )
    this.$el.append view.render().el

  addAllFrames: ->
    @model.each @addFrame

  flip: ->
    @model.flip()

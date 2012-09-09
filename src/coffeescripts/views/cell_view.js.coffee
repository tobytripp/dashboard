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
    console.log "CellView#addFrame", frame, arguments
    view = new Dashboard.FrameView( model: frame )
    this.$el.append view.render().el
    console.log this.el, view.el

  addAllFrames: ->
    @model.each @addFrame

  flip: ->
    @model.flip()

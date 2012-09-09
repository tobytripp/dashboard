class Dashboard.GridRowView extends Backbone.View
  className: "grid"
  
  initialize: ->
    _.bindAll @               # bind all instance methods to this instance
    @model.on "add",   @addCell
    @model.on "reset", @addAllCells
    @model.on "all",   @render
    @render()

  render: ->
    @

  addCell: (cell) ->
    view = new Dashboard.CellView model: cell
    this.$el.append view.render().el

  addAllCells: ->
    @model.each @addCell

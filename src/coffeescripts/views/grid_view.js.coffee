class Dashboard.GridView extends Backbone.View
  tagName:   "table"
  className: "grid"
  rowTemplate: _.template """
    <tr class=\"row\"></tr>
    """

  initialize: (options) ->
    _.bindAll @               # bind all instance methods to this instance
    @columns = options.columns
    @cells = []

    @model.on "add",   @addCell
    @model.on "reset", @addAllCells
    @model.on "all",   @render
    @render()

  render: ->
    @

  addCell: (cell) ->
    console.log "add cell"
    view = new Dashboard.CellView model: cell
    @addCellView view

  addAllCells: ->
    console.log "add all"
    @model.each @addCell

  addCellView: (view) ->
    console.log "  add view"
    @cells.push view
    @currentRow().append view.render().el

  currentRow: ->
    console.log "    getrow ", @cells.length
    return @_newRow() unless @lastRow?
    return @_newRow() if @lastRow.children().size() % @columns == 0
    @lastRow

  _newRow: ->
    console.log "    new row"
    @lastRow = $ @rowTemplate()
    this.$el.append @lastRow
    @lastRow
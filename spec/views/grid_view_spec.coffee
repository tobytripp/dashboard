describe "GridView", ->
  view      = undefined
  dashboard = undefined
  cell      = undefined

  beforeEach ->
    cell = {}
    dashboard =
      cells: [cell, {}, {}, {}]
      each: (callback) -> _.each( this.cells, callback )
    _.extend dashboard, Backbone.Events


  it "accepts a columns option", ->
    v = new Dashboard.GridView model: dashboard, columns: 7
    expect( v.columns ).toEqual 7

  describe "#addAllCells", ->
    beforeEach ->
      view = new Dashboard.GridView model: dashboard

    it "creates a CellView for every Cell in the Dashboard", ->
      cell_view = jasmine.createSpyObj "CellView", ["render"]
      cell_view.render.andReturn cell_view
      cell_view.el = ""
      spyOn( Dashboard, "CellView" ).andReturn cell_view

      view.addAllCells()

      expect( Dashboard.CellView ).toHaveBeenCalledWith( model: cell )

  describe "when the cell count exceeds the column setting", ->
    beforeEach ->
      view = new Dashboard.GridView model: dashboard, columns: 3

    it "creates a second row for the excess", ->
      expect( view.$el.children().length ).toEqual 2
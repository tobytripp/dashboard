describe "GridView", ->
  view      = undefined
  dashboard = undefined
  cell      = undefined

  beforeEach ->
    cell = {}
    dashboard =
      cells: [cell]
      each: (callback) -> _.each( this.cells, callback )
    _.extend dashboard, Backbone.Events

    view = new Dashboard.GridView model: dashboard

  describe "#addAllCells", ->
    it "creates a CellView for every Cell in the Dashboard", ->
      cell_view = jasmine.createSpyObj "CellView", ["render"]
      cell_view.render.andReturn cell_view
      cell_view.el = ""
      spyOn( Dashboard, "CellView" ).andReturn cell_view

      view.addAllCells()

      expect( Dashboard.CellView ).toHaveBeenCalledWith( model: cell )

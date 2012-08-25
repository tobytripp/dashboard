describe "CellView", ->
  cell      = undefined
  view      = undefined
  frameView = undefined

  beforeEach ->
    frameView = jasmine.createSpyObj "FrameView", ["render"]
    frameView.render.andReturn frameView
    frameView.el = $("<div class='frame'></div>")

    spyOn( Dashboard, "FrameView" ).andReturn frameView

    cell = new Dashboard.Cell []

    view = new Dashboard.CellView model: cell
    view.render()

  describe "#addFrame", ->
    it "creates a frame view for the frame", ->
      frame = url: "newFrame"
      view.addFrame( frame )
      expect( Dashboard.FrameView ).toHaveBeenCalledWith( model: frame )

    it "renders the frame view", ->
      view.addFrame {}
      expect( frameView.render ).toHaveBeenCalled()

    it "appends the frame view's element to its own", ->
      view.addFrame {}
      expect( view.$el ).toContain "div.frame"

  describe "#addAllFrames", ->
    it "adds each frame", ->
      spyOn( cell, "each" )
      view.addAllFrames()
      expect( cell.each ).toHaveBeenCalled()

  it "is as wide as the widest of its two elements"

  describe "#flip", ->
    it "delegates to the Cell", ->
      spyOn( cell, "flip" )
      view.flip()

      expect( cell.flip ).toHaveBeenCalled()

  describe "#edit()", ->
    it "displays its edit form"

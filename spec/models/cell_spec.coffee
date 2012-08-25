describe "Cell", ->
  cell          = undefined

  beforeEach ->
    cell = new Dashboard.Cell

  it "should be a collection of Frame models", ->
    cell.add new Dashboard.Frame()
    expect( cell.length ).toEqual 1

  describe "#flip", ->
    frame1 = undefined
    frame2 = undefined

    beforeEach ->
      frame1 = new Dashboard.Frame()
      frame2 = new Dashboard.Frame()
      cell.add [frame1, frame2]

    it "calls #flip on the first two frames", ->
      spyOn( frame1, "flip" )
      spyOn( frame2, "flip" )

      cell.flip()

      expect( frame1.flip ).toHaveBeenCalled()
      expect( frame2.flip ).toHaveBeenCalled()

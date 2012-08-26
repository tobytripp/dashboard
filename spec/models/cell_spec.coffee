describe "Cell", ->
  cell          = undefined
  frame1 = undefined
  frame2 = undefined

  beforeEach ->
    frame1 = new Dashboard.Frame()
    frame2 = new Dashboard.Frame()
    cell = new Dashboard.Cell
    cell.add [frame1, frame2]

  it "should be a collection of Frame models", ->
    expect( cell.frames.length ).toEqual 2

  it "flips the first frame", ->
    expect( cell.at( 0 ).front() ).toBeTruthy()

  describe "#flip", ->
    it "calls #flip on the first two frames", ->
      spyOn( frame1, "flip" )
      spyOn( frame2, "flip" )

      cell.flip()

      expect( frame1.flip ).toHaveBeenCalled()
      expect( frame2.flip ).toHaveBeenCalled()

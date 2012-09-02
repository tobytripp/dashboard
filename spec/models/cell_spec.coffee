describe "Cell", ->
  cell   = undefined
  frame1 = undefined
  frame2 = undefined

  beforeEach ->
    frame1 = new Dashboard.Frame()
    frame2 = new Dashboard.Frame()
    cell   = new Dashboard.Cell
    cell.add [frame1, frame2]

  it "should be a collection of Frame models", ->
    expect( cell.frames.length ).toEqual 2

  it "flips the first frame", ->
    expect( cell.at( 0 ).front() ).toBeTruthy()

  describe "#flip", ->
    it "reverses its face attribute", ->
      cell.flip()
      expect( cell.get( "face" ) ).toEqual 1

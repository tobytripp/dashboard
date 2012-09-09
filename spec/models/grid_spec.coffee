describe "Grid", ->
  class FakeCell extends Backbone.Model
    flip: ->
      @

  grid  = undefined
  timer = undefined
  cell1 = undefined
  cell2 = undefined

  StubTimer = ->
  StubTimer::interval = (ms, callback) -> @callback = callback
  StubTimer::expire = ->
    @callback.call()

  beforeEach ->
    timer = new StubTimer()
    cell1 = new FakeCell()
    spyOn( cell1, "flip" )
    cell2 = new FakeCell()
    spyOn( cell2, "flip" )

    grid  = new Dashboard.Grid( [cell1, cell2], { timer: timer } )

  it "sets a callback on the given timer", ->
    expect( timer.callback ).toBeTruthy()

  it "flips the first cell after a timeout", ->
    timer.expire()
    expect( cell1.flip ).toHaveBeenCalled()

  it "flips the next cell after a second timeout", ->
    timer.expire()
    timer.expire()
    expect( cell2.flip ).toHaveBeenCalled()

  it "returns to the first cell if the timer expires a third time", ->
    timer.expire()
    timer.expire()
    timer.expire()
    expect( cell1.flip ).toHaveBeenCalled()

  describe "#columnWidth", ->
    it "returns the percentage width of a single column", ->
      grid.columns 2
      expect( grid.columnWidth() ).toEqual 50.0

      grid.columns 3
      expect( grid.columnWidth() ).toBeCloseTo( 33.33, 0.001 )

  describe "#rowHeight", ->
    it "returns the percentage height of a single row", ->
      grid.rows 2
      expect( grid.rowHeight() ).toEqual 50.0

      grid.rows 3
      expect( grid.rowHeight() ).toBeCloseTo( 33.33, 0.001 )

  describe "#rows( n )", ->
    beforeEach ->
      spyOn cell1, "set"

    it "returns the current row count if given no argument", ->
      expect( grid.rows() ).toEqual 2

    it "sets the value when given an argument", ->
      grid.rows 3
      expect( grid.rows() ).toEqual 3

    it "sets the height attribute on its cell models", ->
      grid.rows 3
      expect( cell1.set ).toHaveBeenCalledWith "height", (100.0/3)

  describe "#columns( n )", ->
    beforeEach ->
      spyOn cell1, "set"

    it "returns the current column count if given no argument", ->
      expect( grid.columns() ).toEqual 3

    it "sets the value when given an argument", ->
      grid.columns 2
      expect( grid.columns() ).toEqual 2

    it "sets the width attribute on its cell models", ->
      grid.columns 4
      expect( cell1.set ).toHaveBeenCalledWith "width", (100.0/4)

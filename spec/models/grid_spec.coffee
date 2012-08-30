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

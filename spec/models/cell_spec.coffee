describe "Cell", ->
  cell          = undefined
  front_element = undefined
  back_element  = undefined

  beforeEach ->
    spyOn( Dashboard, "Frame" ).andCallFake ->
      frame = jasmine.createSpyObj( "Frame", ["resize", "refresh"] )
      frame.name = "Stub Frame " + new Date().getTime() + Math.random()
      frame.colspan = 1

      console.log frame.name

      frame
    cell = new Dashboard.Cell

  it "should be a collection of Frame models", ->
    cell.add new Dashboard.Frame()
    expect( cell.length ).toEqual 1

  describe "initialization", ->
    it "accepts a container element", ->
      new Dashboard.Cell( front_element )

    it "accepts an optional second container for its 'back'", ->
      new Dashboard.Cell( front_element, back_element )

describe "Frame", ->
  frame = undefined
  beforeEach ->
    frame = new Dashboard.Frame()

  it "accepts a target url", ->
    new Dashboard.Frame( url: "http://localhost" )

  it "accepts a refresh period, optionally", ->
    new Dashboard.Frame( url: "http://localhost", refresh_after: 0 )

  describe "#refresh", ->
    it "triggers a change event", ->
      changed = false
      frame.on "change", -> changed = true

      frame.refresh()

      expect( changed ).toEqual true

  describe "if given a refresh period", ->
    afterEach ->
      frame.halt()

    it "triggers a change event when the period expires", ->
      changed = false
      runs ->
        frame = new Dashboard.Frame( url: "localhost", refresh_after: 0.25 )
        frame.on "change", -> changed = true

      waits 260

      runs ->
        expect( changed ).toEqual true

  describe "#front", ->
    it "should be false by default", ->
      expect( frame.front() ).toBeFalsy()

  describe "#flip", ->
    it "changes the #front attribute on the frame", ->
      frame.flip()
      expect( frame.front() ).toBeTruthy()

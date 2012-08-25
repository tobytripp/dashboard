describe "FrameView", ->
  view  = undefined
  frame = undefined

  beforeEach ->
    frame = new Dashboard.Frame url: "http://localhost"
    view  = new Dashboard.FrameView model: frame

  it "renders an iframe", ->
    expect( $("iframe") ).toBeVisible

  describe "#render", ->
    beforeEach ->
      view.render()

    it "creates an iframe", ->
      expect( view.$el ).toContain "iframe"

    it "sets the iframe's src to the value on the model", ->
      expect( view.$("iframe").attr( "src" ) ).toEqual frame.get( "url" )

    it "wraps the frame in a div", ->
      expect( view.$el ).toBe "div.frame"

    it "adds a 'back' class if the frame is not front-facing", ->
      spyOn( frame, "front" ).andReturn false
      view.render()
      expect( view.$el ).toHaveClass "back"

    it "adds a 'front' class if the frame is front-facing", ->
      spyOn( frame, "front" ).andReturn true
      view.render()
      expect( view.$el ).toHaveClass "front"

  describe "model change", ->
    beforeEach ->
      view.render()

    it "resets the iframe src", ->
      frame.set url: "otherhost"
      frame.trigger "change"
      expect( view.$("iframe").attr( "src" ) ).toEqual "otherhost"

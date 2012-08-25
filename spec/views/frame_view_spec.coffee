describe "FrameView", ->
  view  = undefined
  frame = undefined

  beforeEach ->
    frame = new Dashboard.Frame url: "http://localhost"
    view  = new Dashboard.FrameView model: frame

  it "renders an iframe", ->
    expect( $("iframe") ).toBeVisible

  describe "#render", ->
    it "sets the iframe's src to the value on the model", ->
      view.render()
      expect( view.$el.attr( "src" ) ).toEqual frame.get( "url" )

  describe "model change", ->
    beforeEach ->
      view.render()

    it "resets the iframe src", ->
      frame.set url: "otherhost"
      frame.trigger "change"
      expect( view.$el.attr( "src" ) ).toEqual "otherhost"

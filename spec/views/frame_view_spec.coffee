describe "Dashboard.FrameView", ->
  view  = undefined
  frame = undefined

  beforeEach ->
    frame = new Dashboard.Frame( "http://localhost" )
    view  = new Dashboard.FrameView model: frame

  it "renders an iframe", ->
    expect( $("iframe") ).toBeVisible

  it "sets the iframe's src to the value on the model", ->

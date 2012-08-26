describe "Dashboard", ->
  controller = undefined

  beforeEach ->
    controller = new Dashboard.Controller()

  it "can assemble its parts", ->
    controller.render()
    expect( controller.view.el ).toContain "iframe"

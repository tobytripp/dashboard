describe "Dashboard", ->
  controller = undefined
  el         = undefined
  cell       = undefined

  beforeEach ->
    el = $ "<ul>" +
      "<li><a href=\"a.html\">a</a></li>" +
      "<li><a href=\"b.html\">b</a></li>" +
      "<li><a href=\"c.html\">c</a></li>" +
      "</ul>"
    cell = new Dashboard.Cell()
    spyOn cell, "addUrl"

    spyOn( Dashboard, "Cell" ).andReturn cell
    controller = new Dashboard.Controller el, { columns: 3 }

  describe "construction", ->
    it "creates a cell for every other link in the passed container", ->
      expect( Dashboard.Cell.calls.length ).toEqual 2

    it "adds the url for the link to the cell", ->
      expect( cell.addUrl ).toHaveBeenCalledWith "a.html"

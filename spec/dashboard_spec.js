(function() {

  describe("Dashboard", function() {
    var cell, controller, el;
    controller = void 0;
    el = void 0;
    cell = void 0;
    beforeEach(function() {
      el = $("<ul>" + "<li><a href=\"a.html\">a</a></li>" + "<li><a href=\"b.html\">b</a></li>" + "<li><a href=\"c.html\">c</a></li>" + "</ul>");
      cell = new Dashboard.Cell();
      spyOn(cell, "addUrl");
      spyOn(Dashboard, "Cell").andReturn(cell);
      return controller = new Dashboard.Controller(el, {
        columns: 3
      });
    });
    return describe("construction", function() {
      it("creates a cell for every other link in the passed container", function() {
        return expect(Dashboard.Cell.calls.length).toEqual(2);
      });
      return it("adds the url for the link to the cell", function() {
        return expect(cell.addUrl).toHaveBeenCalledWith("a.html");
      });
    });
  });

}).call(this);

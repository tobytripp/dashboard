(function() {

  describe("Dashboard", function() {
    var controller;
    controller = void 0;
    beforeEach(function() {
      return controller = new Dashboard.Controller();
    });
    return it("can assemble its parts", function() {
      controller.render();
      return expect(controller.view.el).toContain("iframe");
    });
  });

}).call(this);

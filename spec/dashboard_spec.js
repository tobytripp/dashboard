describe( "Dashboard", function() {
  var dashboard;
  var frame;

  beforeEach( function() {
    spyOn( Dashboard, "Frame" ).andCallFake( function() {
      frame = jasmine.createSpyObj( "Frame", ["resize", "refresh"]);
      frame.name = "Stub Frame " + new Date().getTime() + Math.random();
      frame.colspan = 1;

      console.log( frame.name );

      return frame;
    });

    jasmine.getFixtures().fixturesPath = 'spec/fixtures';
    loadFixtures( 'dashboard-ul.html' );

    $("ul#dashboard").dashboard({ columns: 4, rows: 3 });
    dashboard = $("ul#dashboard").data( "dashboard" );
  });

  it( "creates a Frame object for each element in the receiving container", function() {
    expect( Dashboard.Frame ).toHaveBeenCalled();
  });

  it( "orders the frame to size itself", function() {
    expect( frame.resize ).toHaveBeenCalled();
  });

  it( "gives the resize function the current grid dimensions", function() {
    expect( frame.resize ).toHaveBeenCalledWith( 4, 3 );
  });

  describe( "when there are more frame entries than spaces in the grid", function() {
    beforeEach( function() {
      Dashboard.cycleDelayMs = 10;
      $("ul#dashboard").dashboard({ columns: 2, rows: 1 });
      jQuery.fx.off = true
    });

    afterEach( function() {
      clearInterval( dashboard.intervalId );
    });

    it( "orders all cells to flip after a delay", function() {});
  });
});

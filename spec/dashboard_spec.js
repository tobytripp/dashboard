describe( "Dashboard", function() {
  var dashboard;
  var frame;

  beforeEach( function() {
    spyOn( window, "Frame" ).andCallFake( function() {
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
    expect( window.Frame ).toHaveBeenCalled();
  });

  it( "orders the frame to size itself", function() {
    expect( frame.resize ).toHaveBeenCalled();
  });

  it( "gives the resize function the current grid dimensions", function() {
    expect( frame.resize ).toHaveBeenCalledWith( 4, 3 );
  });

  describe( "#swapCells", function() {
    it( "exchanges the two given cell indices", function() {
      dashboard.swapCells( 0, 2 );
      expect( $("ul#dashboard li:first-child").attr( "id" ) ).toEqual( '3' );
    });
  });

  describe( "when there are more frame entries than spaces in the grid", function() {
    beforeEach( function() {
      Dashboard.cycleDelayMs = 10;
      $("ul#dashboard").dashboard({ columns: 2, rows: 1 });
    });

    afterEach( function() {
      clearInterval( dashboard.intervalId );
    });


    it( "resorts the entries after a delay", function() {
      runs( function() {
        expect(
          $("ul#dashboard li:first-child a").attr( "href" )
        ).toEqual( "http://example1.com" );
      });

      waits( Dashboard.cycleDelayMs );

      runs( function() {
        expect(
          $("ul#dashboard li:first-child a").attr( "href" )
        ).toEqual( "http://example3.com" );
      });
    });
  });
});

describe( "Dashboard", function() {
  var dashboard;
  var frame;

  beforeEach( function() {
    frame = jasmine.createSpyObj( "Frame", ["resize"]);
    spyOn( window, "Frame" ).andReturn( frame );

    jasmine.getFixtures().fixturesPath = 'spec/fixtures';
    loadFixtures( 'dashboard-ul.html' );

    $("ul#dashboard").dashboard({ columns: 4, rows: 3 });
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
});

// Local Variables:
// compile-command: "open file:///Users/toby/Code/Javascript/dashboard/spec_runner.html && open -a Emacs"
// End:

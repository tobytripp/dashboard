
describe( "Dashboard", function() {
  var dashboard;
  var frame;

  beforeEach( function() {
    frame = jasmine.createSpyObj( "Frame", ["resize"]);
    spyOn( window, "Frame" ).andReturn( frame );

    dashboard = new Dashboard( new Object(), {
      frames: [{ url: "www.example.com" }],
      columns: 4,
      rows:    3
    });
  });

  it( "creates a Frame object for each config provided in the options", function() {
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
// compile-command: "open file:///Users/toby/Code/Javascript/dashboard/spec_runner.html"
// End:

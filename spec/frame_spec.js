describe( "Frame", function() {
  var frame;

  var container;
  var link;

  beforeEach( function() {
    container = $("<li></li>");
    link      = $("<a></a>");
    container.append( link );

    link.attr( "href", "http://www.example.com" );
    link.text( "FrameName" );

    frame = new Frame( container );
  });

  it( "creates an iframe element", function() {
    expect( container ).toContain( "iframe[seamless]" );
  });

  it( "sets the iframe source to the anchor's href attribute", function() {
    expect( container.find( "iframe" ) ).toBe( "[src=http://www.example.com]" );
  });

  it( "sets the iframe's name to the link text", function() {
    expect( container.find( "iframe") ).toBe( "[name=FrameName]" );
  });

  it( "removes the anchor element", function() {
    expect( container.find( "a" ) ).not.toExist();
  });

  describe( "when the container has a data-colspan attrbute", function() {
    beforeEach( function() {
      container.data( "colspan", 3 );
      frame = new Frame( container );
    });

    it( "sets its colspan property from the attribute value", function() {
      expect( frame.colspan ).toEqual( 3 );
    });
  });

  describe( "#resize", function() {
    var iframe;

    beforeEach( function() {
      frame.colspan = 1;
      frame.resize( 3, 2 );
      iframe = container.find( "iframe" );
    });

    it( "sets the iframe height according to the row count specified", function() {
      expect( iframe ).toHaveAttr( "height", "50%" );
    });

    it( "sets the iframe width according to the column value", function() {
      expect( iframe ).toHaveAttr( "width", "33%" );
    });

    describe( "when the container has a colspan attribute set", function() {
      beforeEach( function() {
        frame.colspan = 2;
        frame.resize( 3, 2 );
      });

      it( "sets the iframe width according to the span value", function() {
        expect( iframe ).toHaveAttr( "width", "66%" );
      });
    });
  });

  describe( "when there is a refresh attribute set", function() {
    it( "sets an interval" );
    it( "resets the iframe src when the interval expires" );
  });
});


// Local Variables:
// compile-command: "open file:///Users/toby/Code/Javascript/dashboard/spec_runner.html && open -a Emacs"
// End:

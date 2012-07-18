;(function($) {
  Function.prototype.bind = function( context ) {
    return $.proxy( this, context );
  }

  var Dashboard = window.Dashboard = function( element, options ) {
    this.options = options;
    this.$elem   = $(element);
    this.frames  = {};

    $.each( options.frames, this.createFrame.bind( this ) );
    this.resizeFrames();

    $(window).resize( this.resizeFrames.bind( this ) );
  };

  MS_PER_S = 1000;

  Dashboard.prototype.createFrame = function( i, options ) {
    var frame = new window.Frame( options );
    this.frames[frame.name] = frame;
    this.$elem.append( frame.$elem );
  }

  Dashboard.prototype.resizeFrames = function() {
    var self = this;
    $.each( this.frames, function( i, frame ) {
      console.log( "resize", self.options );
      frame.resize( self.options.columns, self.options.rows );
    });
  }

  var Frame = window.Frame = function( options ) {
    this.options = $.extend({
      name:    options.url,
      colspan: 1
    }, options );

    this.$elem = $("<iframe seamless></iframe>");

    this.init();

    $.extend( this, this.options );
  }

  Frame.prototype.init = function() {
    var frame = this.$elem;
    frame.attr( "src",  this.options.url );
    frame.attr( "name", this.options.name );

    if( this.options.refresh ) {
      var randOffset = Math.random() * 4;
      setInterval(
        this.refresh.bind( this ),
        (this.options.refresh + randOffset) * MS_PER_S );
    }
  }

  Frame.prototype.refresh = function() {
    console.log( "refresh", this );
    this.$elem.attr( "src", this.url );
  }

  Frame.prototype.resize = function( columns, rows ) {
    console.log( "resize to", columns, rows, this );
    var columnPercentage = (100 / columns);
    var width = columnPercentage * this.colspan;

    this.$elem.attr( "width",  width + "%" );
    this.$elem.attr( "height", (100 / rows) + "%" );
  }

  $.fn.dashboard = function( options ) {
    var settings = $.extend( {
      urls:   [],
      columns: 3,
      rows:    2,
      refresh: undefined // seconds
    }, options );

    return this.each( function() {
      $(this).data( 'dashboard', new Dashboard( this, settings ) );
    });
  };
}(jQuery));

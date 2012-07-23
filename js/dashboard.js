;(function($) {
  var MS_PER_S = 1000;

  Function.prototype.bind = function( context ) {
    return $.proxy( this, context );
  }



  var Dashboard = window.Dashboard = function( element, options ) {
    this.options = options;
    this.$elem   = $(element);
    this.frames  = {};

    this.$elem.children().each( this.createFrame.bind( this ) );
    this.resizeFrames();

    $(window).resize( this.resizeFrames.bind( this ) );
  };

  Dashboard.prototype.createFrame = function( i, element ) {
    var frame = new window.Frame( element );
    this.frames[frame.name] = frame;
  }

  Dashboard.prototype.resizeFrames = function() {
    var self = this;
    $.each( this.frames, function( i, frame ) {
      frame.resize( self.options.columns, self.options.rows );
    });
  }

  Dashboard.prototype.reconfigure = function( options ) {
    this.options = options;
    this.resizeFrames();
  }



  var Frame = window.Frame = function( container ) {
    this.$container = $(container);

    this.getOptionsFrom( this.$container );
    this.init();
  }

  Frame.prototype.init = function() {
    var iframe = $("<iframe seamless></iframe>");
    this.$container.append( iframe );

    iframe.attr( "name", this.name );
    this.$element = iframe;

    if( this.refreshInterval ) this.startAutoRefresh();

    this.refresh();
  }

  Frame.prototype.getOptionsFrom = function( container ) {
    var anchor = container.find( "a" ).remove();
    this.url     = anchor.attr( "href" );
    this.name    = anchor.text();
    this.colspan = container.data( "colspan" ) || 1;
    this.refreshInterval = container.data( "refresh" );
  }

  Frame.prototype.refresh = function() {
    console.log( "Refreshing frame ", this.name, this.intervalId, this.url );
    this.$element.attr( "src", this.url );
  }

  Frame.prototype.startAutoRefresh = function() {
    var randOffset = Math.random() * 2;
    if( this.intervalId ) this.stopRefresh();

    var intervalSeconds = this.refreshInterval + randOffset;
    console.log( "interval (sec) ", intervalSeconds );

    this.intervalId = setInterval(
      this.refresh.bind( this ),
      intervalSeconds * MS_PER_S
    );

    console.log( "started interval ", this.intervalId );
  }

  Frame.prototype.stopRefresh = function() {
    console.log( "stop interval ", this.intervalId );
    clearInterval( this.intervalId );
  }

  Frame.prototype.resize = function( columns, rows ) {
    var columnPercentage = (100.0 / columns);
    var width = columnPercentage * this.colspan;

    this.$container.css( "width",  String( width ) + "%" );
    this.$container.css( "height", String(100 / rows) + "%" );
  }

  $.fn.dashboard = function( options ) {
    var settings = $.extend( {
      columns: 3,
      rows:    2
    }, options );

    return this.each( function() {
      var dashboard = $(this).data( 'dashboard' );

      if( dashboard ) {
        dashboard.reconfigure( settings );
      } else {
        $(this).data( 'dashboard', new Dashboard( this, settings ) );
      }
    });
  };
}(jQuery));

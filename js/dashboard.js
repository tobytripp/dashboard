;(function($) {
  var MS_PER_S = 1000;

  Function.prototype.bind = function( context ) {
    return $.proxy( this, context );
  }



  var Dashboard = window.Dashboard = function( element, options ) {
    this.$elem   = $(element);
    this.frames  = {};
    this.frameCount = 0;

    this.$elem.children().each( this.createFrame.bind( this ) );

    this.reconfigure( options );
    $(window).resize( this.resizeFrames.bind( this ) );
  };

  Dashboard.cycleDelayMs = 2500;

  Dashboard.prototype.createFrame = function( i, element ) {
    var frame = new window.Frame( element );
    this.frames[frame.name] = frame;
    this.frameCount += 1;

    $(element).
        attr( "data-index", i ).
        data( "index", i ).
        data( "updated", new Date() );
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

    if( this.totalOccupiedCells() > this.totalAvailableCells() ) {
      this._startCellRotation();
    }
  }

  Dashboard.prototype.totalAvailableCells = function() {
    return this.options.columns * this.options.rows;
  }

  Dashboard.prototype.totalOccupiedCells = function() {
    var count = 0;

    for( var name in this.frames ) {
      var f = this.frames[name];
      count = count + f.colspan;
    }

    return count;
  }

  Dashboard.prototype.rotateCells = function() {
    this.swapCells( 0, this.frameCount - 1 );
  }

  Dashboard.prototype._startCellRotation = function() {
    this.intervalId = setInterval(
      this.rotateCells.bind( this ),
      Dashboard.cycleDelayMs
    )
  }

  Dashboard.prototype.swapCells = function( i, j ) {
    console.log( "swap: ", i, j );
    var $elem = this.$elem;

    this.$elem.children().each( function() {
      var ix = $(this).data( 'index' );
      if( ix == i ) { $(this).data( 'index', j ); }
      if( ix == j ) { $(this).data( 'index', i ); }
    }).sort( function( a, b ) {
      return $(a).data( "index" ) - $(b).data( "index" );
    }).appendTo( this.$elem );
  }





  var Frame = window.Frame = function( container ) {
    this.$container = $(container);

    this.init();
  }

  Frame.maximumRefreshDelay = 2;

  Frame.prototype.init = function() {
    this.getOptionsFrom( this.$container );
    this.$element = this._createIFrameIn( this.$container );

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
    var randOffset = Math.random() * Frame.maximumRefreshDelay;
    if( this.intervalId ) this.stopRefresh();

    var intervalSeconds = this.refreshInterval + randOffset;

    this.intervalId = setInterval(
      this.refresh.bind( this ),
      intervalSeconds * MS_PER_S
    );
  }

  Frame.prototype.stopRefresh = function() {
    clearInterval( this.intervalId );
  }

  Frame.prototype.resize = function( columns, rows ) {
    var columnPercentage = (100.0 / columns);
    var width = columnPercentage * this.colspan;

    this.$container.css( "width",  String( width ) + "%" );
    this.$container.css( "height", String(100 / rows) + "%" );
  }

  Frame.prototype._createIFrameIn = function( container ) {
    var iframe = container.find( "iframe" );

    if( iframe.size() == 0 ) {
      iframe = $("<iframe seamless></iframe>");
      container.append( iframe );
    }

    iframe.attr( "name", this.name );
    return iframe;
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

(function() {
  var $, _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  $ = void 0;

  if ((_ref = window.Dashboard) == null) {
    window.Dashboard = {};
  }

  Dashboard.Frame = (function(_super) {

    __extends(Frame, _super);

    function Frame() {
      return Frame.__super__.constructor.apply(this, arguments);
    }

    Frame.BACK = 0;

    Frame.FRONT = 1;

    Frame.prototype.defaults = {
      refresh_rate: void 0,
      face: Frame.BACK
    };

    Frame.prototype.initialize = function() {
      var refresh_after;
      refresh_after = this.get("refresh_after");
      this.refresh_after_ms = refresh_after && (refresh_after * 1000);
      if (this.refresh_after_ms != null) {
        return this.start_refresh(this.refresh_after_ms);
      }
    };

    Frame.prototype.start_refresh = function(period) {
      return this.interval_id = setInterval(_.bind(this.refresh, this), period);
    };

    Frame.prototype.halt = function() {
      return clearInterval(this.interval_id);
    };

    Frame.prototype.refresh = function() {
      return this.trigger("change");
    };

    Frame.prototype.front = function() {
      return this.get('face') === Frame.FRONT;
    };

    Frame.prototype.flip = function() {
      var face;
      face = this.get('face');
      face = (face + 1) % 2;
      this.set('face', face);
      return this;
    };

    return Frame;

  })(Backbone.Model);

}).call(this);
(function() {
  var $, FrameSet,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  $ = void 0;

  FrameSet = (function(_super) {

    __extends(FrameSet, _super);

    function FrameSet() {
      return FrameSet.__super__.constructor.apply(this, arguments);
    }

    FrameSet.prototype.model = Dashboard.Frame;

    return FrameSet;

  })(Backbone.Collection);

  Dashboard.Cell = (function(_super) {

    __extends(Cell, _super);

    function Cell() {
      return Cell.__super__.constructor.apply(this, arguments);
    }

    Cell.prototype.defaults = {
      face: 0
    };

    Cell.prototype.initialize = function() {
      var _this = this;
      this.frames = new FrameSet();
      this.frames.on("add", this.assert_face, this);
      return this.frames.on("add", function(frame) {
        return _this.trigger("cell:add", frame, _this);
      });
    };

    Cell.prototype.at = function(index) {
      return this.frames.at(index);
    };

    Cell.prototype.each = function(callback) {
      return this.frames.each(callback);
    };

    Cell.prototype.add = function(frames) {
      return this.frames.add(frames);
    };

    Cell.prototype.flip = function() {
      var face;
      face = this.get('face');
      return this.set('face', (face + 1) % 2);
    };

    Cell.prototype.assert_face = function() {
      var front_frame;
      front_frame = this.frames.find(function(frame) {
        return frame.front();
      });
      if (!front_frame) {
        return this.frames.at(0).flip();
      }
    };

    Cell.prototype.backFacing = function() {
      return this.get("face") > 0;
    };

    return Cell;

  })(Backbone.Model);

}).call(this);
(function() {
  var Timer;

  Timer = function() {};

  Timer.prototype.interval = function(ms, callback) {
    return this.id = window.setInterval(callback, ms);
  };

  Timer.prototype.once = function(ms, callback) {
    return this.id = window.setTimeout(callback, ms);
  };

  Timer.prototype.stop = function() {
    return window.clearInterval(this.id);
  };

}).call(this);
(function() {
  var $,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  $ = void 0;

  Dashboard.Grid = (function(_super) {

    __extends(Grid, _super);

    function Grid() {
      return Grid.__super__.constructor.apply(this, arguments);
    }

    Grid.prototype.model = Dashboard.Cell;

    Grid.prototype.initialize = function(cells, options) {
      var _ref,
        _this = this;
      if (options == null) {
        options = {};
      }
      this.timer = options.timer;
      if ((_ref = this.timer) == null) {
        this.timer = new Timer();
      }
      this.timer.interval(3000, function() {
        return _this.rotate();
      });
      this.last_rotated_index = -1;
      this.row_count = 2;
      return this.column_count = 3;
    };

    Grid.prototype.rotate = function() {
      this.last_rotated_index = (this.last_rotated_index + 1) % this.length;
      return this.at(this.last_rotated_index).flip();
    };

    Grid.prototype.columnWidth = function() {
      return 100.0 / this.columns();
    };

    Grid.prototype.rowHeight = function() {
      return 100.0 / this.rows();
    };

    Grid.prototype.rows = function(n) {
      var _this = this;
      if (n != null) {
        this.row_count = n;
        this.each(function(cell) {
          return cell.set("height", _this.rowHeight());
        });
      }
      return this.row_count;
    };

    Grid.prototype.columns = function(n) {
      var _this = this;
      if (n != null) {
        this.column_count = n;
        this.each(function(cell) {
          return cell.set("width", _this.columnWidth());
        });
      }
      return this.column_count;
    };

    return Grid;

  })(Backbone.Collection);

}).call(this);

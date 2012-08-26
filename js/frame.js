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

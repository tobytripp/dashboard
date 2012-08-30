(function() {
  var $,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  $ = jQuery;

  Dashboard.FrameView = (function(_super) {

    __extends(FrameView, _super);

    function FrameView() {
      return FrameView.__super__.constructor.apply(this, arguments);
    }

    FrameView.prototype.tagname = 'div';

    FrameView.prototype.className = 'frame';

    FrameView.prototype.initialize = function() {
      _.bindAll(this);
      this.model.on("change", this.render);
      this.frame = $("<iframe seamless></iframe>");
      this.$el.append(this.frame);
      return this.render();
    };

    FrameView.prototype.render = function() {
      this.frame.attr("name", this.model.get("url"));
      this.frame.attr("scrolling", "no");
      this.frame.attr("src", this.model.get("url"));
      this.setFace();
      return this;
    };

    FrameView.prototype.setFace = function() {
      this.$el.toggleClass("front", this.model.front());
      return this.$el.toggleClass("back", !this.model.front());
    };

    return FrameView;

  })(Backbone.View);

}).call(this);

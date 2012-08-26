(function() {
  var $,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  $ = jQuery;

  Dashboard.CellView = (function(_super) {

    __extends(CellView, _super);

    function CellView() {
      return CellView.__super__.constructor.apply(this, arguments);
    }

    CellView.prototype.tagname = "div";

    CellView.prototype.className = "cell";

    CellView.prototype.initialize = function() {
      _.bindAll(this);
      this.model.on('cell:add', this.addFrame);
      this.model.on('all', this.render);
      this.render();
      return this.addAllFrames();
    };

    CellView.prototype.render = function() {
      return this;
    };

    CellView.prototype.addFrame = function(frame, inCell) {
      var view;
      console.log("CellView#addFrame", frame, arguments);
      view = new Dashboard.FrameView({
        model: frame
      });
      this.$el.append(view.render().el);
      return console.log(this.el, view.el);
    };

    CellView.prototype.addAllFrames = function() {
      return this.model.each(this.addFrame);
    };

    CellView.prototype.flip = function() {
      return this.model.flip();
    };

    return CellView;

  })(Backbone.View);

}).call(this);

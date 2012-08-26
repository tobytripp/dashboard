(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Dashboard.GridView = (function(_super) {

    __extends(GridView, _super);

    function GridView() {
      return GridView.__super__.constructor.apply(this, arguments);
    }

    GridView.prototype.initialize = function() {
      _.bindAll(this);
      this.model.on("add", this.addCell);
      this.model.on("reset", this.addAllCells);
      this.model.on("all", this.render);
      return this.render();
    };

    GridView.prototype.render = function() {
      return this;
    };

    GridView.prototype.addCell = function(cell) {
      var view;
      view = new Dashboard.CellView({
        model: cell
      });
      return this.$el.append(view.render().el);
    };

    GridView.prototype.addAllCells = function() {
      return this.model.each(this.addCell);
    };

    return GridView;

  })(Backbone.View);

}).call(this);

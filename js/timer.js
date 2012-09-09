(function() {

  window.Timer = function() {};

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

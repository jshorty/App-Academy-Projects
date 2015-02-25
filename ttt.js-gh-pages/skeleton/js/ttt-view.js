(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
  };

  View.prototype.bindEvents = function () {
  };

  View.prototype.makeMove = function ($square) {
  };

  View.prototype.setupBoard = function () {
    this.$el.append("<ul></ul>");
    var $grid = $("ul");
    $grid.addClass("grid group");
    $grid.append("<li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li><li></li>");
  };
})();

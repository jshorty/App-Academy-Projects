(function () {
  if (typeof TTT === "undefined") {
    window.TTT = {};
  }

  var View = TTT.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupBoard();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var view = this;
    this.$el.find("li").on("click", function (event) {
      var $target = $(event.currentTarget);
      view.makeMove($target);
    })
  };

  View.prototype.makeMove = function ($square) {
    var val = parseInt($square.attr("pos"));
    var pos = this.parseVal(val);
    if (this.game.board.isEmptyPos(pos)) {
      $square.addClass(this.game.currentPlayer);
      this.game.board.placeMark(pos, this.game.currentPlayer);
      this.game.swapTurn();
      if (this.game.board.isOver() && this.game.board.winner() === null) {
        alert("Tie game.");
        this.$el.find("li").off("click");
      }
      else if (this.game.board.isOver()) {
        alert(this.game.board.winner() + " wins!");
        this.$el.find("li").off("click");
      }
    }
    else {
      alert("Invalid move!");
    }
  };

  View.prototype.setupBoard = function () {
    this.$el.append("<ul>");
    var $grid = $("ul");
    $grid.addClass("grid group");
    for (var i = 0; i < 9; i++) {
      var $li = $("<li>");
      $li.attr("pos", i);
      $grid.append($li)
    }
  };

  View.prototype.parseVal = function(val) {
    var positions = [[0,0],[0,1],[0,2],[1,0],[1,1],[1,2],[2,0],[2,1],[2,2]];
    return positions[val];
  };
})();

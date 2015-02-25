(function () {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function (game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupPiles();
    this.bindEvents();
  };

  View.prototype.bindEvents = function () {
    var view = this;
    view.$el.find(".pile").on("click", function (event) {
      var $from = $(this);
      $from.toggleClass("selected");
      view.$el.find(".pile").on("click", function (event) {
        var $to = $(this);
        $from.toggleClass("selected");
        $to.toggleClass("selected");
        view.$el.find(".pile").off("click");
        view.makeMove($from, $to);
      })
    })
  };

  View.prototype.makeMove = function ($from, $to) {
    var from = parseInt($from.attr("id"));
    var to = parseInt($to.attr("id"));
    if (!this.game.move(from, to)) {
      alert("Invalid move!");
    }
    this.render();
    if (this.game.isWon()) {
      alert("You Win!");
    }
    else {
      this.bindEvents();
    }
  };

  View.prototype.setupPiles = function () {
    this.$el.addClass("group");
    for (i = 0; i < 3; i++) {
      var $ul = $("<ul>");
      $ul.addClass("pile");
      $ul.attr("id", i);
      this.$el.append($ul);
    }
    $("ul").append("<li><li><li>");
    this.render()
  };

  View.prototype.render = function () {
    var view = this;
    for (var i = 0; i < 3; i++) {
      var $tower = $("ul").eq(i);
      var $discs = $tower.find("li");
      for (var j = 0; j < 3; j++) {
        var towers = view.game.towers[i];
        $discs.eq(2-j).removeClass();
        switch(towers[j]) {
          case 1:
            $discs.eq(2-j).addClass("one");
            break;
          case 2:
            $discs.eq(2-j).addClass("two");
            break;
          case 3:
            $discs.eq(2-j).addClass("three");
            break;
          default:
            break;
        }
      }
    }
  }




})();

TrelloClone.Collections.Boards = Backbone.Collection.extend({
  model: TrelloClone.Models.Board,
  url: "api/boards",

  getOrFetch: function (id) {
    var board = this.get(id);
    var boards = this;

    if (!board) {
      var board = new TrelloClone.Models.Board({id: id});
      board.fetch({
        success: function () {
          boards.add(board);
        }
      });
    } else {
      board.fetch();
    }
    return board;
  }
});

TrelloClone.Collections.boards = new TrelloClone.Collections.Boards();

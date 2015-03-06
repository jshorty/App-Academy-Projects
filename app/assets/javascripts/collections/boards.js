TrelloClone.Collections.Boards = Backbone.Board.extend({
  initialize: function (options) {
    this.model = options.model;
  },

  url: "api/boards"
});

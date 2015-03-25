TrelloClone.Collections.Lists = Backbone.Collection.extend({

  model: TrelloClone.Models.List,

  url: "api/lists",

  initialize: function (_, options) {
    this.board = options.board;
  },
})

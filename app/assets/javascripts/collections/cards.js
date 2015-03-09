TrelloClone.Collections.Cards = Backbone.Collection.extend({

  model: TrelloClone.Models.Card,

  url: "api/cards",

  initialize: function (_, options) {
    this.list = options.list;
  },

  comparator: function () {
    return this.get('ord');
  }
})

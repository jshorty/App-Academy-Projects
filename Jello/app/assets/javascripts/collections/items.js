TrelloClone.Collections.Items = Backbone.Collection.extend({

  model: TrelloClone.Models.Item,

  url: "api/items",

  initialize: function (_, options) {
    this.card = options.card;
  },

  comparator: function () {
    return this.get('ord');
  }
})

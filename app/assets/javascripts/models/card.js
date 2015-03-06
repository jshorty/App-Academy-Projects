TrelloClone.Models.Card = Backbone.Model.extend({
  urlRoot: "api/cards"
});

TrelloClone.Models.List = Backbone.Model.extend({
  urlRoot: "api/lists",

  parse: function (payload) {
    if (payload.items) {
      var items = this.items().set(payload.items, {parse: true})
    delete payload.items;
    }
    return payload;
  },

  items: function () {
    if (!this._items) {
      this._items = new TrelloClone.Collections.Items([], {list: this})
    }
    return this._items;
  }
});

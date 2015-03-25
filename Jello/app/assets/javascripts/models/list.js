TrelloClone.Models.List = Backbone.Model.extend({
  urlRoot: "api/lists",

  parse: function (payload) {
    if (payload.cards) {
      var cards = this.cards().set(payload.cards, {parse: true})
    delete payload.cards;
    }
    return payload;
  },

  cards: function () {
    if (!this._cards) {
      this._cards = new TrelloClone.Collections.Cards([], {list: this})
    }
    return this._cards;
  }
});

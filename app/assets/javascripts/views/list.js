TrelloClone.Views.List = Backbone.CompositeView.extend({
  template: JST["list"],

  events: {
    "click .add-card":"createNewCard"
  },

  initialize: function (options) {
    this.model = options.model;
    this.cards = this.model.cards();
    this.listenTo(this.cards, "add remove change:title", this.render)
  },

  tagName: "li",
  className: "list-container",

  render: function () {
    var content = this.template({list: this.model});
    this.$el.html(content);
    this.model.cards().each(function (card) {
      this.addSubview("ul.list", new TrelloClone.Views.Card({model: card}));
    }, this)
    return this;
  },

  createNewCard: function () {
    this.addSubview("ul.list", new TrelloClone.Views.CardForm({
      model: new TrelloClone.Models.Card(),
      list: this.model
    }))
  }
});

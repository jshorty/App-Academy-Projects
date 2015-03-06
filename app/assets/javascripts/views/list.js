TrelloClone.Views.List = Backbone.CompositeView.extend({
  template: JST["list"],

  initialize: function (options) {
    this.model = options.model;
    this.subs = []
  },

  tagName: "li",

  render: function () {
    console.log("LIST RENDERED");
    var content = this.template({list: this.model});
    this.$el.html(content);
    this.model.cards().each(function (card) {
      this.addSubview("ul.list", new TrelloClone.Views.Card({model: card}));
    }, this)
    return this;
  }
});

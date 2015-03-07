TrelloClone.Views.Card = Backbone.CompositeView.extend({
  template: JST["card"],

  initialize: function (options) {
    this.model = options.model;
  },

  tagName: "li",
  className: "card-container",

  render: function () {
    var content = this.template({card: this.model});
    this.$el.html(content);
    this.model.items().each(function (item) {
      this.addSubview("ul.card", new TrelloClone.Views.Item({model: item}));
    }, this)
    return this;
  }
});

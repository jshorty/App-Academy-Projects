TrelloClone.Views.Card = Backbone.CompositeView.extend({
  template: JST["card"],

  initialize: function (options) {
    this.model = options.model;
  },

  tagName: "li",

  render: function () {
    console.log("CARD RENDERED");
    var content = this.template({card: this.model});
    this.$el.html(content);
    return this;
  }
});

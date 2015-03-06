TrelloClone.Views.Item = Backbone.CompositeView.extend({
  template: JST["item"],

  initialize: function (options) {
    this.model = options.model;
  },

  tagName: "li",

  render: function () {
    var content = this.template({item: this.model});
    this.$el.html(content);
    return this;
  }
});

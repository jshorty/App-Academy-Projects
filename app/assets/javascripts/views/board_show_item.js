TrelloClone.Views.BoardShowItem = Backbone.View.extend({
  template: JST["board_show_item"],

  initialize: function (options) {
    this.model = options.model;
  },

  tagName: "li",

  render: function () {
    var content = this.template({list: this.model});
    this.$el.html(content);
    return this;
  }
});

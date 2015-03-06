TrelloClone.Views.BoardIndexItem = Backbone.View.extend({
  template: JST["board_index_item"],

  initialize: function (options) {
    this.model = options.model;
  },

  tagName: "li",

  render: function () {
    var content = this.template({board: this.model});
    this.$el.html(content);
    return this;
  }
});

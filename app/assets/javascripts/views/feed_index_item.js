NewsReader.Views.FeedIndexItem = Backbone.View.extend({
  template: JST["feed_list_item"],

  tagName: "li",

  render: function () {
    var content = this.template({feed: this.model});
    this.$el.html(content);
    return this;
  },

  events: {
    "click #delete": "deleteItem"
  },

  deleteItem: function (event) {
    this.remove();
    this.model.destroy();
  }
})

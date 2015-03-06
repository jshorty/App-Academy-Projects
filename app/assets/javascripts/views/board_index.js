TrelloClone.Views.BoardIndex = Backbone.View.extend({
  template: JST["board_index"],

  tagName: "ul",

  initialize: function (options) {
    this.collection = options.collection;
    this.listenTo(this.collection, "add sync", this.render);
    this.subviews = [];
  },

  render: function () {
    var content = this.template({boards: this.collection});
    this.$el.html(content);

    this.collection.each(function (board) {
      var subview = new TrelloClone.Views.BoardIndexItem({model: board});
      this.subviews.push(subview)
      this.$el.append(subview.render().$el);
    }, this);

    return this;
  },

  remove: function () {
    Backbone.View.prototype.remove.call(this);
    this.subviews.forEach(function (subview) {
      subview.remove();
    });
    this.subviews = [];
  }
});

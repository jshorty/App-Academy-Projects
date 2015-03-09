TrelloClone.Views.BoardIndex = Backbone.CompositeView.extend({
  template: JST["board_index"],
  tagName: "ul",

  events: {
    "click .delete-board":"deleteBoard"
  },

  initialize: function (options) {
    this.collection = options.collection;
    this.listenTo(this.collection, "add remove sync", this.render);
  },

  render: function () {
    var content = this.template({boards: this.collection});
    this.$el.html(content);

    this.collection.each(function (board) {
      this.addSubview("#board-index", new TrelloClone.Views.BoardIndexItem({model: board}));
    }, this);

    this.addSubview("#new-board-form", new TrelloClone.Views.BoardForm());

    return this;
  },

  deleteBoard: function (event) {
    if (window.confirm("Delete this board?")) {
      this.collection.get($(event.currentTarget).attr("board")).destroy();
    }
  }
});

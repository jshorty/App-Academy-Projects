TrelloClone.Routers.Router = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
    this.boards = TrelloClone.Collections.boards;
    this.boards.fetch();
  },

  routes: {
    "": "boardIndex",
    "boards/new": "boardForm",
    "boards/:id": "boardShow"
  },

  boardShow: function (id) {
    var board = this.boards.getOrFetch(id);
    this._swapView(new TrelloClone.Views.Board({model: board}));
  },

  boardIndex: function () {
    this._swapView(new TrelloClone.Views.BoardIndex({collection: this.boards}));
  },

  boardForm: function () {
    this._swapView(new TrelloClone.Views.BoardForm());
  },


  _swapView: function (view) {
    this.currentView && this.currentView.remove();
    this.currentView = view;
    this.$rootEl.html(view.render().$el);
  }
})

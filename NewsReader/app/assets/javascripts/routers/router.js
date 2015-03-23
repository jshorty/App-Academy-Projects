NewsReader.Routers.Router = Backbone.Router.extend({
  initialize: function (option) {
    this.$container = option.container;
    this.feeds = new NewsReader.Collections.Feeds();
    this.feeds.fetch();
  },

  routes: {
    "": "feedIndex",
    "feeds/new": "feedForm",
    "feeds/:id": "feedShow",
    "login": "userForm",
    "logout": "logout"
  },

  feedIndex: function () {
    this._swapView(new NewsReader.Views.FeedIndex({ collection: this.feeds }))
  },

  feedShow: function (id) {
    var feed = this.feeds.getOrFetch(id);
    this._swapView(new NewsReader.Views.FeedShow({ model: feed }));
  },

  feedForm: function () {
    this._swapView(new NewsReader.Views.FeedForm({collection: this.feeds}));
  },

  userForm: function () {
    this._swapView(new NewsReader.Views.UserForm());
  },

  logout: function () {

  },

  checkedLoggedIn: function () {

  },

  _swapView: function (view) {
    this.currentView && this.currentView.remove();
    this.currentView = view;
    this.$container.html(this.currentView.render().$el);
  }


})

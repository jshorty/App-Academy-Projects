NewsReader.Views.FeedIndex = Backbone.View.extend({
  template: JST["feed_index"],

  tagName: "ul",

  initialize: function () {
    this.listenTo(this.collection, "sync", this.render.bind(this));
    this.subViews = []
  },
  
  render: function () {
    var content = this.template();
    this.$el.html(content);
    this.collection.each(function (feed) {
      var feedIndexItem = new NewsReader.Views.FeedIndexItem({model: feed});
      this.subViews.push(feedIndexItem)
      this.$el.append(feedIndexItem.render().$el)
    }.bind(this));

    return this;
  },

  remove: function () {
    Backbone.View.prototype.remove.call(this);
    this.subViews.forEach( function (view) {
      view.remove();
    })
    this.subViews = [];
  }
})

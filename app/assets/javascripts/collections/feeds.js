NewsReader.Collections.Feeds = Backbone.Collection.extend({
  url: "api/feeds",
  model: NewsReader.Models.Feed,

  getOrFetch: function (id) {
    var feed = this.get(id);
    var success;

    if (!feed) {
      feed = new NewsReader.Models.Feed();
      feed.set("id", id);
      success = function () {
        this.add(feed)
      }.bind(this)
    }

    feed.fetch({success: success})

    return feed;
  },

  comparator: function (model) {
    // debugger
    return model.get("title");
  }
})

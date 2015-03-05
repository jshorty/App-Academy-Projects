NewsReader.Collections.Entries = Backbone.Collection.extend({
  initialize: function (_, option) {
    this.feed = option.feed
  },

  url: function () {
    return (this.feed.url() + '/entries');
  },

  model: NewsReader.Models.Entry,

  // comparator: "created_at"

  //
  comparator: function (model) {
    // debugger
    return model.get("title");
  }
})

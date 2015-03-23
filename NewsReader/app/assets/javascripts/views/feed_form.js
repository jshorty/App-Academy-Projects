NewsReader.Views.FeedForm = Backbone.View.extend({

  template: JST["feed_form"],

  tagName: "form",

  events : {
    "submit": "submitForm"
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submitForm: function (event) {
    event.preventDefault();
    var attr = $(event.currentTarget).serializeJSON();
    var feed = new NewsReader.Models.Feed();
    feed.save(attr, {
      success: function () {
        this.collection.add(feed);
        Backbone.history.navigate("/feeds/" + feed.id, {trigger: true})
      }.bind(this)
    })
  }
})

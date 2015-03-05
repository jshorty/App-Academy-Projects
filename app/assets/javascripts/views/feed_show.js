NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST["feed_show"],

  tagName: "ul",

  initialize: function (options) {
    this.model = options.model
    this.listenTo(this.model, "sync sort", this.render);
    call = this.model.entries()
    this.subViews = [];
  },

  events: {
    "click #refresh": "refreshView"
  },

  render: function () {
    console.log("rendering")
    var content = this.template({feed: this.model});
    this.$el.html(content);
    this.model.entries().each(function (entry) {
      console.log(new Date(entry.get("created_at")).getTime())
      var feedShowItem = new NewsReader.Views.FeedShowItem({model: entry});
      this.subViews.push(feedShowItem)
      this.$el.append(feedShowItem.render().$el)
    }.bind(this));

    return this;
  },

  remove: function () {
    Backbone.View.prototype.remove.call(this);
    this.subViews.forEach( function (view) {
      view.remove();
    })
    this.subViews = [];
  },

  refreshView: function () {
    console.log("test")
    this.model.fetch();
  }
})

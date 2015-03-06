TrelloClone.Views.BoardShow = Backbone.View.extend({
  template: JST["board_show"],

  initialize: function (options) {
    this.model = options.model;
    this.listenTo(this.model, "sync", this.render);
    this.subviews = [];
  },

  render: function () {
    var content = this.template({board: this.model});
    this.$el.html(content);
    this.model.lists().each(function (list) {
      var subview = new TrelloClone.Views.BoardShowItem({model: list});
      console.log(this.subviews);
      this.subviews.push(subview)
      this.$el.append(subview.render().$el);
    }, this)
    return this;
  },

  remove: function () {
    Backbone.View.prototype.remove.call(this);
    this.subviews.forEach(function (subview) {
      subview.remove();
    });
    this.subviews = [];
  }
})

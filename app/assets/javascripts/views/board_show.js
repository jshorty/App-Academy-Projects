TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  template: JST["board_show"],

  initialize: function (options) {
    this.model = options.model;
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({board: this.model});
    this.$el.html(content);
    this.model.lists().each(function (list) {
      this.addSubview("ul", new TrelloClone.Views.BoardShowItem({model: list}));
    }, this)
    return this;
  },
  // 
  // remove: function () {
  //   Backbone.View.prototype.remove.call(this);
  //   this.subviews.forEach(function (subview) {
  //     subview.remove();
  //   });
  //   this.subviews = [];
  // }
})

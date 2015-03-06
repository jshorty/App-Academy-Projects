TrelloClone.Views.Board = Backbone.CompositeView.extend({
  template: JST["board"],

  initialize: function (options) {
    this.model = options.model;
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var content = this.template({board: this.model});
    this.$el.html(content);
    this.model.lists().each(function (list) {
      this.addSubview("#board", new TrelloClone.Views.List({model: list}));
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

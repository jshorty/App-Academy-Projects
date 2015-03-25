TrelloClone.Views.Item = Backbone.CompositeView.extend({
  template: JST["item"],

  events: {
    "change #card-item-checkbox":"toggleDone"
  },

  initialize: function (options) {
    this.model = options.model;
    this.card = options.card;
  },

  tagName: "li",
  className: "item-container",

  render: function () {
    var content = this.template({item: this.model});
    this.$el.html(content);
    return this;
  },

  toggleDone: function (event) {
    // var title = $(event.currentTarget).attr("item-title");
    // this.card.items().models.each(function(item) {
    //   if (item.get('title') = title) {
    //     var item = item;
    //   }
    // });
    // console.log(item);
    // console.log(item.get('done'));
    // if (item.get('done')) {
    //   item.set('done', false);
    // } else {
    //   item.set('done', true);
    // }
    // item.save();
  }
});

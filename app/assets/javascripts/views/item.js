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
    console.log("CHECKED");
    // if (this.model.get('done')) {
    //   this.model.set('done', false)
    // } else {
    //   this.model.set('done', true)
    // }
    // console.log(this.model);
    // this.model.save();

    // this.card.items().add(this.model, {merge: true})
    //
    // this.card.save({
    //    success: function () {
    //      console.log(this.card.items());
    //    }.bind(this)
    // });
  }
});

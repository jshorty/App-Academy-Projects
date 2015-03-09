TrelloClone.Views.Card = Backbone.CompositeView.extend({
  template: JST["card"],

  events: {
    "click .add-item":"createNewItem"
  },

  initialize: function (options) {
    this.model = options.model;
    this.items = this.model.items();
    this.listenTo(this.items, "add remove change:title", this.render)
  },

  tagName: "li",
  className: "card-container",

  render: function () {
    var content = this.template({card: this.model});
    this.$el.html(content);
    this.model.items().each(function (item) {
      this.addSubview("ul.card", new TrelloClone.Views.Item({model: item, card: this.model}));
    }, this)
    return this;
  },

  createNewItem: function () {
    this.openForm = new TrelloClone.Views.ItemForm({
      model: new TrelloClone.Models.Item(),
      card: this.model
    })
    this.addSubview("ul.card", this.openForm)
  }
});

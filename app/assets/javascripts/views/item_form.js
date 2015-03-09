TrelloClone.Views.ItemForm = Backbone.CompositeView.extend({
  template: JST["item_form"],
  tagName: "form",
  className: "item-container",

  events: {
    "submit":"submitForm",
    "click .close":"remove"
  },

  initialize: function (options) {
    this.model = options.model
    this.card = options.card
  },

  render: function () {
    var content = this.template({item: this.model});
    this.$el.html(content);
    return this;
  },

  submitForm: function (event) {
    view = this;
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON().item;
    data.card_id = this.card.id;
    console.log(data);
    view.model.save(data, {
      success: function () {
        view.card.items().add(view.model)
      },
      error: function (errors) {
        $(event.currentTarget).append(errors)
      }
    })
  }
});

TrelloClone.Views.CardForm = Backbone.CompositeView.extend({
  template: JST["card_form"],
  tagName: "form",
  className: "card-container",

  events: {
    "submit":"submitForm"
  },

  initialize: function (options) {
    this.model = options.model
    this.list = options.list
  },

  render: function () {
    var content = this.template({card: this.model});
    this.$el.html(content);
    return this;
  },

  submitForm: function (event) {
    view = this;
    event.preventDefault();
    var data = $(event.currentTarget).serializeJSON().card;
    data.list_id = this.list.id;
    console.log(data);
    view.model.save(data, {
      success: function () {
        view.list.cards().add(view.model)
      },
      error: function (errors) {
        $(event.currentTarget).append(errors)
      }
    })
  }
});

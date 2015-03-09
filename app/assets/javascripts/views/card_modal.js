TrelloClone.Views.CardModal = Backbone.View.extend({
  initialize: function (options) {
    this.model = options.model
  },

  template: JST["card_modal"],
  tagName: "section",
  className: "modal-background",

  render: function () {
    console.log("RENDERING");
    var content = this.template({card: this.model})
    this.$el.html(content);
    return this;
  }
})

NewsReader.Views.UserForm = Backbone.View.extend({
  template: JST["user_form"],

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this
  },

  events: {
    "submit": "submitForm"
  },

  tagName: "form",

  submitForm: function (event) {
    event.preventDefault();
    var attrs = $(event.currentTarget).serializeJSON();
    new NewsReader.Models.User().save(attrs, {
      success: function () {
        Backbone.history.navigate("#", {trigger: true})
      }
    })
  }
})

TrelloClone.Views.BoardForm = Backbone.View.extend({
  template: JST["board_form"],

  tagName: "form",

  initialize: function (options) {
    if (options && options.model) {
      this.model = options.model;
    }
    else {
      this.model = new TrelloClone.Models.Board();
    }
  },

  render: function () {
    var content = this.template({board: this.model});
    this.$el.html(content);
    return this;
  },

  events: {
    "click #board-form-submit": "submit"
  },

  submit: function (event) {
    view = this;
    event.preventDefault();
    var formData = this.$el.serializeJSON();
    view.model.save(formData, {
      success: function () {
        TrelloClone.Collections.boards.add(view.model)
        Backbone.history.navigate("", {trigger: true})
      },
      error: function (errors) {
        this.$el.append(errors)
      }
    });
  }
})

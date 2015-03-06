TrelloClone.Views.Board = Backbone.CompositeView.extend({
  template: JST["board"],

  events: {
    "submit #new-list": "newList"
  },

  initialize: function (options) {
    this.model = options.model;
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.lists(), "add", this.render);
  },

  render: function () {
    var content = this.template({board: this.model});
    this.$el.html(content);
    this.model.lists().each(function (list) {
      this.addSubview("#board", new TrelloClone.Views.List({model: list}));
    }, this)
    return this;
  },

  newList: function (event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON();
    var board = this.model
    var list = new TrelloClone.Models.List(formData);
    list.save({}, {
      success: function () {
        board.lists().add(list)
      },
      error: function (errors) {
        $(event.currentTarget).append(errors)
      }
    });
  }
})

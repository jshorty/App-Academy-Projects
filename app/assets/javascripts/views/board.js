TrelloClone.Views.Board = Backbone.CompositeView.extend({
  template: JST["board"],

  events: {
    "submit #new-list": "newList",
    "click .card-container h4":"openModal"
  },

  initialize: function (options) {
    this.model = options.model;
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.lists(), "add remove", this.render);
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
  },

  openModal: function(event){
    console.log("CLICK");
    var cardId = $(event.currentTarget).parent().attr('card-id');
    var card = new TrelloClone.Models.Card({id: cardId});
    console.log(card);
    card.fetch();
    this.$el.append(new TrelloClone.Views.CardModal({model: card}).render().el)
  },
})

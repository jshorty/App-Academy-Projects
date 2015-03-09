TrelloClone.Views.List = Backbone.CompositeView.extend({
  template: JST["list"],

  events: {
    "click .add-card":"createNewCard",
    "click .delete":"deleteList",
  },

  initialize: function (options) {
    this.model = options.model;
    this.cards = this.model.cards();
    this.listenTo(this.cards, "add remove change:title", this.render)
  },

  tagName: "li",
  className: "list-container",

  render: function () {
    var content = this.template({list: this.model});
    this.$el.html(content);

    this.model.cards().each(function (card) {
      this.addSubview("ul.list", new TrelloClone.Views.Card({model: card}));
    }, this)

    this.allowCardSorting();

    return this;
  },

  createNewCard: function () {
    this.openForm = new TrelloClone.Views.CardForm({
      model: new TrelloClone.Models.Card(),
      list: this.model
    })
    this.addSubview("ul.list", this.openForm)
  },

  deleteList: function () {
    if (window.confirm("Delete this list?")) {
      this.model.destroy();
    }
  },

  allowCardSorting: function () {
    var view = this;
    var cardOrder = [];
    this.$(".list").sortable({
      update: function (event, ui) {
        $(ui.item).parent().children().each(function (idx) {
          var id = $(this).attr("card-id");
          view.model.cards().get(id).set("ord", idx).save();
        })
      }
    });
    this.$(".list").disableSelection();
  }
});

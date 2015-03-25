TrelloClone.Views.Card = Backbone.CompositeView.extend({
  template: JST["card"],

  events: {
    "click .add-item":"createNewItem",
    "click .delete-card":"deleteCard",
    "click h4":"openModal"
  },

  initialize: function (options) {
    this.model = options.model;
    this.items = this.model.items();
    this.listenTo(this.items, "add remove change:title", this.render)
    this.$el.attr("card-id", this.model.id)
  },

  tagName: "li",
  className: "card-container",

  render: function () {
    var content = this.template({card: this.model});
    this.$el.html(content);
    this.model.items().each(function (item) {
      this.addSubview("ul.card", new TrelloClone.Views.Item({model: item, card: this.model}));
    }, this)

    this.allowItemSorting();

    return this;
  },

  createNewItem: function () {
    this.openForm = new TrelloClone.Views.ItemForm({
      model: new TrelloClone.Models.Item(),
      card: this.model
    })
    this.addSubview("ul.card", this.openForm)
  },

  deleteCard: function (event) {
    if (window.confirm("Delete this card?")) {
      this.model.destroy();
    }
  },

  allowItemSorting: function () {
    var view = this;
    var itemOrder = [];
    this.$(".card").sortable({
      update: function (event, ui) {
        $(ui.item).parent().children().each(function (idx) {
          var id = $(this).attr("item-id");
          view.model.items().get(id).set("ord", idx).save();
        })
      }
    });
    this.$(".card").disableSelection();
  }
});

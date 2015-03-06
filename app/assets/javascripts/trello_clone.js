window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.$rootEl = $("#main"),
    this.$newButton = $(".glyphicon.glyphicon-plus")
    this.router = new TrelloClone.Routers.Router({$rootEl: this.$rootEl,
        $newButton: this.$newButton});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});

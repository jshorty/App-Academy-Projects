window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    this.$rootEl = $("#main"),
    this.router = new TrelloClone.Routers.Router({$rootEl: this.$rootEl});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});

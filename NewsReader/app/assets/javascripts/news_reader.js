window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var $container = $('#content')
    router = new NewsReader.Routers.Router({container: $container});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});

require(["jquery", "backbone", "underscore", "cs!dock/dock"], function($, Backbone, _, Dock) {

    var EventConsoleRouter = Backbone.Router.extend({
        routes: {
            "": "root"
        },

        root: function() {
            var dock = new Dock({ slotCount: 5 });
            dock.add("#videoPlayer");
            dock.add("#slides");
            dock.add("#home");
            dock.add("#qanda");
            dock.add("<div>");
            dock.render();
            $("#dock").append(dock.el);

            setTimeout(function() { $('*').removeClass("hidden"); }, 0);
        }
    });

    var eventConsoleRouter = new EventConsoleRouter;
    Backbone.history.start();

});

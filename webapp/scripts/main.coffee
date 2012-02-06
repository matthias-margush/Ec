require ["jquery", "backbone", "underscore", 'cs!dock/dock', 'cs!player/player'], ($, Backbone, _, Dock, Player) ->

   EventConsoleRouter = Backbone.Router.extend
        routes: {
            "": "root"
        }

        root: () ->
            dock = new Dock({ slotCount: 5 });
            dock.add("#videoPlayer");
            dock.add("#slides");
            dock.add("#home");
            dock.add("#qanda");
            dock.add("<div>");

            player = new Player({
                el: '#videoPlayer',
                playButton: '#playButton',
                playImage: "play.png",
                pauseImage: "pause.png",
            });

            # $(function() {
            # });

            setTimeout(() ->
               dock.render();
               $("#dock").append(dock.el);
               $('*').removeClass("hidden");
            , 0)



    eventConsoleRouter = new EventConsoleRouter
    Backbone.history.start()
    console.log "Started backbone history"


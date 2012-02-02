define [ 'jquery', 'backbone', 'underscore'], ($, Backbone, _) ->

    Backbone.View.extend
        initialize: () ->
            _.defaults(@options, {
                playButtonTag: '#playButton',
                playImage: 'play.png',
                pauseImage: 'pause.png',
            });

            video = @el;
            playButton = $(@options.playButtonTag)
            playImage = @options.playImage
            pauseImage = @options.pauseImage

            $(@options.playButtonTag).click () ->
                if video.paused
                    playButton.attr 'src', pauseImage
                    video.play()
                else
                    playButton.attr 'src', playImage
                    video.pause()


        events:
            'click': 'fullscreen'

        fullscreen: () ->
            @el.webkitEnterFullscreen()

        playToggle: () ->


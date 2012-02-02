define [ 'jquery', 'backbone', 'underscore',  'order!text!dock/dock-templates.html!strip'], ($, Backbone, _, dockTemplates) ->

    positionAt = (node, slot) ->
        $slot = $(slot)
        $node = $(node)

        return if $node.width() == 0 or $node.height() == 0

        position = $slot.offset()
        scaleX = $slot.width() / $node.width()
        scaleY = $slot.height() / $node.height()
        reverseScaleX = $node.width() / $slot.width()
        reverseScaleY = $node.height() / $slot.height()
        scale = Math.min scaleX, scaleY
        reverseScale = Math.max reverseScaleX, reverseScaleY

        if scaleX > scaleY
            #position.left = scale * (Math.abs($slot.width() - $node.width()) / 4)
            console.log "Adjusted left: #{position.left}"
        else
            position.top = scale * (position.top + ($slot.height() - $node.height()) / 4)
            #console.log "Adjusted top: #{position.top}"

        console.log "Padding: #{$node.css('margin')}"
        marginLeft = $node.css('margin-left');
        margionTop = $node.css('margin-top');
        css = {
            top: "#{position.top - marginTop}px"
            left: "#{position.left - marginLeft}px"
            width: "#{$slot.width()}px"
            height: "#{$slot.height()}px"
            #'-webkit-transform': "scaleX(#{scaleX}) scaleY(#{scaleY})"
        }
        $(node).css(css)

    $('body').append(dockTemplates)

    Backbone.View.extend
        className: 'dock'

        initialize: () ->
            _.defaults(@options, { undockable: -1, undock: '.undock', dockables: [] });
            @template = _.template $('#dock_template').html()
            @slotTemplate = _.template $('#dock_slot_template').html()


        events:
            'click .slot': 'undock'

        render: () ->
            @$el.html(this.template())

            for i in [0...(@options.dockables.length)]
                @$el.append @slotTemplate { height: (100 / @options.dockables.length) }

            self = this;
            setTimeout () ->
                for i in [0...(self.options.dockables.length)]
                    if i is self.options.undockable
                        positionAt self.options.dockables[i], self.options.undock
                        $(self.options.dockables[i]).addClass("docked animates").removeClass("undocked hidden")
                    else
                        positionAt self.options.dockables[i], self.$el.children()[i]
                        $(self.options.dockables[i]).addClass("undocked animates").removeClass("docked hidden")
                0

        add: (dockable) ->
            $(dockable).addClass 'dockable'
            @options.dockables.push dockable

        undock: (event) ->
            @options.undockable = $(event.target).index()
            @render()


define [ 'jquery', 'backbone', 'underscore',  'order!text!dock/dock-templates.html!strip'], ($, Backbone, _, dockTemplates) ->

    positionAt = (node, slot) ->
        $slot = $(slot)
        $node = $(node)
        position = $slot.offset()
        marginLeft = ($node.outerWidth(true) - $node.innerWidth()) / 2
        marginTop = ($node.outerHeight(true) - $node.innerHeight()) / 2
        css = {
            top: "#{position.top - marginTop}px"
            left: "#{position.left - marginLeft}px"
            width: "#{$slot.width()}px"
            height: "#{$slot.height()}px"
        }
        $(node).css(css)

    $('body').append(dockTemplates)

    Backbone.View.extend
        className: 'dock'

        events:
            'click .spot': 'undock'

        initialize: () ->
            _.defaults(@options, {
                 undockable: -1,
                 undock: '.undock',
                 dockables: []
            });
            @template = _.template $('#dock_template').html()
            @slotTemplate = _.template $('#dock_slot_template').html()

        render: () ->
            @$el.html this.template()
            dockArea = @$el;

            for i in [0...(@options.dockables.length)]
                dockArea.append @slotTemplate {
                    height: "#{(100 / @options.dockables.length)}%"
                }

            self = this;
            setTimeout () ->
                for i in [0...(self.options.dockables.length)]
                    if i is self.options.undockable
                        positionAt self.options.dockables[i],
                            self.options.undock
                        $(self.options.dockables[i])
                                .addClass("docked animates")
                                .removeClass("undocked hidden")
                    else
                        positionAt self.options.dockables[i],
                            $(".slot", dockArea)[i]
                        $(self.options.dockables[i])
                                .addClass("undocked animates")
                                .removeClass("docked hidden")
                0

        add: (dockable) ->
            $(dockable).addClass 'dockable'
            @options.dockables.push dockable

        undock: (event) ->
            @options.undockable = $(event.currentTarget).index()
            @render()


define(["jquery", "backbone", "underscore", "text!dock/dock-templates.html!strip"], function($, Backbone, _, dock_templates) {
    
    $("body").append(dock_templates);
    
    var Dock = Backbone.View.extend({

        className: "dock",

        events: {
            //        "click .icon":          "open",
            //        "click .button.edit":   "openEditDialog",
            //        "click .button.delete": "destroy"
        },

        initialize: function() {
            this.template = _.template($("#dock_template").html());
        },

        render: function() {
            this.$el.html(this.template());
        }
    });

    return Dock;
});

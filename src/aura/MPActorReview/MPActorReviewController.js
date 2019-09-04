({
    MPShowReviews : function(component, event, helper){
        let id = event.getParam("id");
        let context = event.getParam("context");
        let display = event.getParam("display");
        component.set("v.displayedSection", display);
        component.set("v.context", context);
        console.log('review ' + id +' ' + context);
    },

    MPHideReview : function(component, event, helper){
                         let display = event.getParam("display");
                         component.set("v.displayedSection", display);
                         console.log('review closed');
                         }
})
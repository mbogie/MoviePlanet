({
    MPShowReviews: function (component, event, helper) {
        let id = event.getParam("id");
        let context = event.getParam("context");
        let display = event.getParam("display");
        component.set("v.displayedSection", display);
        component.set("v.context", context);
        component.set("v.id", id);
        component.set("v.tabSelected", "one");
        console.log('review ' + id + ' ' + context);
    },

    MPHideReview: function (component, event, helper) {
        let display = event.getParam("display");
        component.set("v.displayedSection", display);
        console.log('review closed');
    },

    onClick: function (component, event, helper) {
        let rev = $A.get("e.c:MPGetReviewsEvent");
        rev.fire();
        console.log('after rev');
    },

    MPReviewAdded: function (component, event, helper) {
        component.set("v.tabSelected", "one");
    },
})
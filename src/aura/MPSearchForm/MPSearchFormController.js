({
    onFormSubmit: function (component, event, helper) {
        let context = component.find("searchTypes").get("v.value");
        let query = component.get("v.query");
        if (query != "") {
            // console.log('search form --> ' + context + ' ' + query);
            let searchEvent = $A.get("e.c:MPPassSearchValues");
            searchEvent.setParams({
                "query": query,
                "context": context
            });
            searchEvent.fire();
        } else {
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "type": "info",
                "message": "Query is required"
            });
            toastEvent.fire();
        }
    },

    goHome: function (component, event, helper) {
        component.set("v.displayedSection", true);
        component.set("v.query", "");
        let actorEvent = $A.get("e.c:MPHomePageEvent");
        actorEvent.setParams({
            "context": "popular"
        });
        actorEvent.fire();
    },

    MPHideSearchComponentEvent: function (component, event, handler) {
        let display2 = event.getParam("display");
        component.set("v.displayedSection", display2);
        //  console.log('hide search form' + display2);
    },

    MPShowSearchComponentEvent: function (component, event, handler) {
        let show = event.getParam("display");
        component.set("v.displayedSection", show);
    },

    MPSetHomePage: function (component, event, handler) {
        //     console.log('show search form ');
        component.set("v.query", "");
        let showHomePage = $A.get("e.c:MPHomePageEvent");
        showHomePage.setParams({
            "context": "popular"
        });
        showHomePage.fire();
        component.set("v.displayedSection", true);
    },

    openModel: function (component, event, helper) {
        component.set("v.isOpen", true);
    },

    onCancel: function (component, event, helper) {
        event.preventDefault();
        component.set("v.isOpen", false);
    },

    onSubmit: function (component, event, helper) {
        event.preventDefault();
        const fields = event.getParam('fields');
        let movieJson = JSON.stringify(fields);
        let addMovie = component.get("c.addMovie");
        addMovie.setParams({
            movie: movieJson
        });
        addMovie.setCallback(this, function (response) {
            if (component.isValid() && response.getState() === 'SUCCESS') {
                component.set("v.movie", response.getReturnValue());
                console.log(response.getReturnValue());
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "success",
                    "message": " New Movie Added"
                });
                toastEvent.fire();
                component.set("v.isOpen", false);

            } else {
                let toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "type": "error",
                    "message": response.getError()[0].message
                });
                toastEvent.fire();
                //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
            }
        });
        $A.enqueueAction(addMovie);
    },

    blacklist: function (component, event, helper) {
        let searchEvent = $A.get("e.c:MPPassSearchValues");
        searchEvent.setParams({
            "query": "",
            "context": "BF"
        });
        searchEvent.fire();
    },
})
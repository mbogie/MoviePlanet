({
    doInit: function (component, event, helper) {
        helper.onInit(component, event, helper);
    },

    showSpinner: function (component, event, helper) {
        // make Spinner attribute true for display loading spinner
        component.set("v.Spinner", true);
    },

    // this function automatic call by aura:doneWaiting event
    hideSpinner: function (component, event, helper) {
        // make Spinner attribute to false for hide loading spinner
        component.set("v.Spinner", false);
    },

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
        component.set("v.displayedSection", true);
        component.set("v.query", "");
        console.log('jestem w home');
        let showHomePage = $A.get("e.c:MPHomePageEvent");
        showHomePage.setParams({
            "context": "popular"
        });
        showHomePage.fire();
    },

    openModel: function (component, event, helper) {
        component.set("v.isOpen", true);
    },

    nextStep: function (component, event, helper) {
        let step = component.get("v.step");
        if(step == 1){
            component.set("v.disabledTitle", true);
            step++;
            component.set("v.step", step);
        }
    },

    saveMovie: function (component, event, helper) {
        let step = component.get("v.step");
        let title = component.get("v.newMovie").Name;
        console.log(title + ' <----');
//        component.find("movieForm").submit();
        step++;
        component.set("v.step", step);
        let action = component.get("c.getMovieId");
                            action.setParams({
                                movie: component.get("v.newMovie"),
                            });
                            action.setCallback(this, function (response) {
                                if (component.isValid() && response.getState() === 'SUCCESS') {
                                    let movieId = response.getReturnValue();
                                    console.log(response.getReturnValue());
                                    component.set("v.newMovieId", movieId);
                                } else {
                                    let toastEvent = $A.get("e.force:showToast");
                                     toastEvent.setParams({
                                     "type": "error",
                                        "message": response.getError()[0].message
                                        });
                                        toastEvent.fire();
                                    }
                            });
                            $A.enqueueAction(action);
    },

    addImage: function (component, event, helper) {
        let step = component.get("v.step");
        step++;
        component.set("v.step", step);
    },

    handleSuccess : function(component, event, helper) {
            var payload = event.getParams().response;
            console.log(payload.id);
        },

    onCancel: function (component, event, helper) {
        component.set("v.isOpen", false);
        component.set("v.disabledButton", true);
        component.set("v.disabledTitle", false);
        component.set("v.newMovie", {});
        component.set("v.reset", false);
        component.set("v.reset", true);
        component.set("v.step", 1);
        helper.onInit(component, event, helper);
    },

    checkMovie : function (component, event, helper) {
        let movie = component.get("v.newMovie");
        let movieName = movie.Name;
        console.log('name--> ' + movie.Genres__c);
        if(movieName) {
            console.log('1');
            let checkMovie = component.get("c.checkMovieInside");
            console.log('2');
            checkMovie.setParams({
                movie: movieName
            });
            console.log('3');
            checkMovie.setCallback(this, function (response) {
                if (component.isValid() && response.getState() === 'SUCCESS') {
                    console.log(response.getReturnValue());
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "type": "success",
                        "message": response.getReturnValue()
                    });
                    toastEvent.fire();
                    component.set("v.disabledButton", false);
                } else {
                    let toastEvent = $A.get("e.force:showToast");
                    toastEvent.setParams({
                        "type": "error",
                        "message": response.getError()[0].message
                    });
                    toastEvent.fire();
                    component.set("v.disabledButton", true);
                    //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                }
            });
             $A.enqueueAction(checkMovie);
        } else {
            let toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
                "type": "info",
                "message": "Fill the Title"
            });
            toastEvent.fire();
        }
    },

    onSubmit: function (component, event, helper) {
        component.find("nameField").set("v.value", "My New Account");
        component.set("v.val", 'aaa');
        event.preventDefault();
        const fields = event.getParam('fields');
        let movieJson = JSON.stringify(fields);
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
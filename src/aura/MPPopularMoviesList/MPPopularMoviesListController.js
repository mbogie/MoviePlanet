({
    doInit: function (component, event, helper) {
                component.set("v.Spinner", true);
        let action = component.get("c.getPopularMovies");
        action.setCallback(this, function (response) {
            if (component.isValid() && response.getState() === 'SUCCESS') {
                component.set("v.popularMovies", response.getReturnValue());
                console.log(response.getReturnValue());
            } else {
                //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
            }
        });
        $A.enqueueAction(action);
               component.set("v.Spinner", false);

    },

    MPPassSearchValues: function (component, event, helper) {
                component.set("v.Spinner", true);

        let searchContext = event.getParam("context");
        component.set("v.context", searchContext);
        let searchQuery = event.getParam("query");
        component.set("v.query", searchQuery);
        component.set("v.pageNumber", 1);
        if (searchContext == "Movie") {
            console.log('before movie search');
            let action = component.get("c.searchMovies");
            action.setParams({
                query: searchQuery,
                page: 1
            });
            action.setCallback(this, function (response) {
                if (component.isValid() && response.getState() === 'SUCCESS') {
                    let movies = response.getReturnValue();
                    component.set("v.searchedMovies", movies);
                    console.log(response.getReturnValue());
                    component.set("v.totalPages", movies.total_pages);
                } else {
//              component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                }
            });
            $A.enqueueAction(action);
        }
        if (searchContext == "Actor") {
            console.log('before actor search');
            let action = component.get("c.searchActors");
            action.setParams({
                query: searchQuery,
                page: 1
            });
            action.setCallback(this, function (response) {
                if (component.isValid() && response.getState() === 'SUCCESS') {
                    let actors = response.getReturnValue();
                    console.log(response.getReturnValue());
                    component.set("v.searchedActors", actors);
                    component.set("v.totalPages", actors.total_pages);
                } else {
                    //              component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                }
            });
            $A.enqueueAction(action);
        }
        if (searchContext == "BF") {
            let action = component.get("c.getBF");
            action.setCallback(this, function (response) {
                if (component.isValid() && response.getState() === 'SUCCESS') {
                   // let bf = response.getReturnValue();
                    console.log(response.getReturnValue());
                    component.set("v.bf", response.getReturnValue());
                } else {
                    //              component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                }
            });
            $A.enqueueAction(action);
        }
               component.set("v.Spinner", false);

    },

    MPHomePageEvent: function (component, event, helper) {
        console.log('show home from detail');
        let context = event.getParam("context");
        component.set("v.context", context);
        component.set("v.query", "");
        component.set("v.displayedSection", true);
/*        let action = component.get("c.getPopularMovies");
        action.setCallback(this, function (response) {
                    if (component.isValid() && response.getState() === 'SUCCESS') {
                        component.set("v.popularMovies", response.getReturnValue());
                        console.log(response.getReturnValue());
                    } else {
                        //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                    }
        });
                $A.enqueueAction(action);
        console.log('show home from detail2');*/
    },

    MPHideSearchComponentEvent: function (component, event, helper) {
        console.log('movie list');
        let display = event.getParam("display");
        component.set("v.displayedSection", display);
    },

    MPShowSearchComponentEvent: function (component, event, handler) {
        let show = event.getParam("display");
        component.set("v.displayedSection", show);
        console.log('show search form ' + show);
    },

    nextPage: function (component, event, handler) {
                component.set("v.Spinner", true);

        console.log('aa');
        let context = component.get("v.context");
        let page = component.get("v.pageNumber") + 1;
        let query = component.get("v.query");
        console.log(context + ' ' + page + ' ' + query)
        if (context == "Movie") {
            let action = component.get("c.searchMovies");
            action.setParams({
                query: query,
                page: page
            });
            action.setCallback(this, function (response) {
                if (component.isValid() && response.getState() === 'SUCCESS') {
                    let movies = response.getReturnValue();
                    component.set("v.searchedMovies", movies);
                    component.set("v.pageNumber", movies.page);
                    console.log(response.getReturnValue());
                } else {
                    //              component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                }
            });
            $A.enqueueAction(action);
        }
        if (context == "Actor") {
            let action = component.get("c.searchActors");
            action.setParams({
                query: query,
                page: page
            });
            action.setCallback(this, function (response) {
                if (component.isValid() && response.getState() === 'SUCCESS') {
                    let actors = response.getReturnValue();
                    console.log(response.getReturnValue());
                    component.set("v.searchedActors", actors);
                    component.set("v.pageNumber", actors.page);
                } else {
                    //              component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                }
            });
            $A.enqueueAction(action);
        }
       component.set("v.Spinner", false);

    },

    previousPage: function (component, event, handler) {
                component.set("v.Spinner", true);

        let context = component.get("v.context");
        let page = component.get("v.pageNumber") - 1;
        let query = component.get("v.query");
        if (context == "Movie") {
            let action = component.get("c.searchMovies");
            action.setParams({
                query: query,
                page: page
            });
            action.setCallback(this, function (response) {
                if (component.isValid() && response.getState() === 'SUCCESS') {
                    let movies = response.getReturnValue();
                    component.set("v.searchedMovies", movies);
                    component.set("v.pageNumber", movies.page);
                    console.log(response.getReturnValue());
                } else {
                    //              component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                }
            });
            $A.enqueueAction(action);
        }
        if (context == "Actor") {
            let action = component.get("c.searchActors");
            action.setParams({
                query: query,
                page: page
            });
            action.setCallback(this, function (response) {
                if (component.isValid() && response.getState() === 'SUCCESS') {
                    let actors = response.getReturnValue();
                    console.log(response.getReturnValue());
                    component.set("v.searchedActors", actors);
                    component.set("v.pageNumber", actors.page);
                } else {
                    //              component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                }
            });
            $A.enqueueAction(action);
        }
               component.set("v.Spinner", false);

    },

    MPRefreshPage : function (component, event, handler) {
                component.set("v.Spinner", true);

        let display = component.get('v.displayedSection');
        let context = component.get("v.context");
        let page = component.get("v.pageNumber");
        let query = component.get("v.query");
        console.log('context --> ', context);
        console.log('page --> ', page);
        console.log('query --> ', query);
        if(display){
        if (context == "Movie") {
            console.log('before movie search');
            let action = component.get("c.searchMovies");
            action.setParams({
                query: query,
                page: page
            });
            action.setCallback(this, function (response) {
                if (component.isValid() && response.getState() === 'SUCCESS') {
                    let movies = response.getReturnValue();
                    component.set("v.searchedMovies", movies);
                    console.log(response.getReturnValue());
                    component.set("v.totalPages", movies.total_pages);
                } else {
//              component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                }
            });
            $A.enqueueAction(action);

        }
        if (context == "Actor") {
            console.log('before actor search');
            let action = component.get("c.searchActors");
            action.setParams({
                query: query,
                page: page
            });
            action.setCallback(this, function (response) {
                if (component.isValid() && response.getState() === 'SUCCESS') {
                    let actors = response.getReturnValue();
                    console.log(response.getReturnValue());
                    component.set("v.searchedActors", actors);
                    component.set("v.totalPages", actors.total_pages);
                } else {
                    //              component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                }
            });
            $A.enqueueAction(action);
        }
        if (context == "BF") {
            let action = component.get("c.getBF");
            action.setCallback(this, function (response) {
                if (component.isValid() && response.getState() === 'SUCCESS') {
                   // let bf = response.getReturnValue();
                    console.log(response.getReturnValue());
                    component.set("v.bf", response.getReturnValue());
                } else {
                    //              component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                }
            });
            $A.enqueueAction(action);
        }
        if (context == "popular") {
        let action = component.get("c.getPopularMovies");
                action.setCallback(this, function (response) {
                    if (component.isValid() && response.getState() === 'SUCCESS') {
                        component.set("v.popularMovies", response.getReturnValue());
                        console.log(response.getReturnValue());
                    } else {
                        //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                    }
                });
        $A.enqueueAction(action);
        }
        }
               component.set("v.Spinner", false);

    },
})
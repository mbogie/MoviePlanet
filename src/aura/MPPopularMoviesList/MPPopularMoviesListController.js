({
    doInit : function(component, event, helper) {
    		let action = component.get( "c.getPopularMovies" );
            action.setCallback( this, function( response ) {
                  if ( component.isValid() && response.getState() === 'SUCCESS' ) {
                      component.set("v.popularMovies", response.getReturnValue());
                      console.log(response.getReturnValue());
                  } else {
                     //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                  }
              });
              $A.enqueueAction(action);
      	},

    MPPassMoviesEvent : function(component, event, helper) {
                    let movies = event.getParam("movieList");
                    let context = event.getParam("context");
                    component.set("v.searchedMovies", movies);
                    component.set("v.context", context);
//                    component.set("v.displayedSection",true);
//                    console.log(component.get("v.displayedSection"));
              },

    MPPassActorsEvent : function(component, event, helper) {
              let actors = event.getParam("actorList");
              let context = event.getParam("context");
              component.set("v.searchedActors", actors);
              component.set("v.context", context);
//              component.set("v.displayedSection","true");
              },

    MPHomePageEvent : function(component, event, helper) {
        console.log('aa');
        let context = event.getParam("context");
        component.set("v.context", context);
        component.set("v.displayedSection", true);
    },

    MPHideSearchComponentEvent : function(component, event, helper) {
            console.log('movie list');
           let display = event.getParam("display");
           component.set("v.displayedSection",display);
         },

    MPShowSearchComponentEvent : function(component,event,handler){
        let show = event.getParam("display");
        component.set("v.displayedSection", show);
        console.log('show search form ' + show);
        }

 })
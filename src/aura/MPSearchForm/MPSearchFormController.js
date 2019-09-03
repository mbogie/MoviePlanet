({
    onFormSubmit:function(component, event, helper) {
       let context = component.find("searchTypes").get("v.value");
       let query = component.get("v.query");
       if(context == "Movie"){
                   console.log("movie");

       let action = component.get("c.searchMovies");
       action.setParams({
       query: query,
       });
       action.setCallback( this , function(response){
       if ( component.isValid() && response.getState() === 'SUCCESS' ) {
               let movies = response.getReturnValue();
               console.log(response.getReturnValue());
               let movieEvent = $A.get("e.c:MPPassMoviesEvent");
               movieEvent.setParams({
                   "context" : "movie",
                   "movieList" : movies
                   });
               movieEvent.fire();
        } else {
//              component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
       }
       });
       $A.enqueueAction(action);
       }
       if(context == "Actor"){
                   console.log("actor");
              let action = component.get("c.searchActors");
              action.setParams({
              query: query,
              });
              action.setCallback( this , function(response){
              if ( component.isValid() && response.getState() === 'SUCCESS' ) {
                      let actors = response.getReturnValue();
                      console.log(response.getReturnValue());
                      let actorEvent = $A.get("e.c:MPPassActorsEvent");
                      actorEvent.setParams({
                          "context" : "actor",
                          "actorList" : actors
                          });
                      actorEvent.fire();
               } else {
       //              component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
              }
              });
              $A.enqueueAction(action);
              }
    },
        goHome:function(component, event, helper) {
            console.log('a');
            component.set("v.query", "");
                let actorEvent = $A.get("e.c:MPHomePageEvent");
                      actorEvent.setParams({
                          "context" : "popular"
                          });
                      actorEvent.fire();
        },

    MPHideSearchComponentEvent : function(component,event,handler){
        let display2 = event.getParam("display");
        component.set("v.displayedSection", display2);
        console.log('hide search form' + display2);
    },

    MPShowSearchComponentEvent : function(component,event,handler){
        let show = event.getParam("display");
        component.set("v.displayedSection", show);
        console.log('show search form ' + show);
        },
})
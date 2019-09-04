({
    doInit : function(component, event, helper) {
            let movie = component.get("v.movie");
      	},

    onSelect : function(component, event, helper) {
        let hideMovie = $A.get("e.c:MPHideActorDetailEvent");
                      hideMovie.setParams({
                              "display" : false
                              });
                              hideMovie.fire();
        let movieId = component.get("v.movie").id;
        let action = $A.get("e.c:MPSelectedMovieEvent");
                      action.setParams({
                          "movieId" : movieId,
                          "display" : true
                          });
                      action.fire();
            let showReviews = $A.get("e.c:MPShowReviews");
                                 showReviews.setParams({
                                 "id" : movieId,
                                 "display" : true,
                                 "context" : "Movie"
                                 });
                                 showReviews.fire();
            let hide = $A.get("e.c:MPHideSearchComponentEvent");
                      hide.setParams({
                      "display" : false
                      });
                      hide.fire();

    },
 })
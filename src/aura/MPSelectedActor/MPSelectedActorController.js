({
        MPSelectedActorEvent : function(component,event,handler){
        component.set("v.selectedTabId", "one");
        component.set("v.actor", "{}");
        let actorId = event.getParam("actorId");
        let display = event.getParam('display');
        component.set("v.displayedSection", display);
        let action = component.get( "c.getActorDetail" );
        action.setParams({
                           actorId: actorId
                           });
        action.setCallback( this, function( response ) {
        if ( component.isValid() && response.getState() === 'SUCCESS' ) {
               component.set("v.actor", response.getReturnValue());
               console.log(response.getReturnValue());
               } else {
                             //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
               }
               });
        $A.enqueueAction(action);
        let getMovies = component.get("c.getActorFilmography");
            getMovies.setParams({
                            actorId: actorId
                            });
                    getMovies.setCallback( this, function( response ) {
                    if ( component.isValid() && response.getState() === 'SUCCESS' ) {
                           component.set("v.movies", response.getReturnValue());
                           console.log(response.getReturnValue());
                           } else {
                                         //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                           }
                           });
                           $A.enqueueAction(getMovies);


    },
    goBack : function(component,event,handler){
    component.set("v.displayedSection", false);
    let hide = $A.get("e.c:MPShowSearchComponentEvent");
                           hide.setParams({
                           "display" : true
                           });
                           hide.fire();
    console.log('hide');
    let hideReview = $A.get("e.c:MPHideReview");
                                     hideReview.setParams({
                                     "display" : false,
                                     });
                                     hideReview.fire();
    },

    goHome : function(component,event,handler){
        component.set("v.displayedSection", false);
        let showHome = $A.get("e.c:MPSetHomePage");
        showHome.fire();
        console.log('hide');
        let hideReview = $A.get("e.c:MPHideReview");
                                             hideReview.setParams({
                                             "display" : false,
                                             });
                                             hideReview.fire();
        },

    MPHideActorDetailEvent : function(component,event,handler){
                 let display = event.getParam('display');
                 component.set("v.displayedSection", display);
     },
     getImages  : function(component,event,handler){
            let getImage = component.get("c.getActorImages");
            let aId = component.get("v.actor").id;

            getImage.setParams({
                  actorId: aId
                  });
            getImage.setCallback( this, function( response ) {
                 if ( component.isValid() && response.getState() === 'SUCCESS' ) {
                    component.set("v.images", response.getReturnValue());
                    console.log(response.getReturnValue());
                    } else {
                                         //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                           }
                           });
                 $A.enqueueAction(getImage);

     },
})
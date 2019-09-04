({
    MPSelectedMovieEvent : function(component,event,handler){
        component.set("v.selectedTabId", "one");
        component.set("v.movie", "{}");
        let movieId = event.getParam("movieId");
        let display = event.getParam('display');
        component.set("v.displayedSection", display);
        let action = component.get( "c.getMovieDetail" );
        action.setParams({
                           movieId: movieId
                           });
        action.setCallback( this, function( response ) {
        if ( component.isValid() && response.getState() === 'SUCCESS' ) {
               component.set("v.movie", response.getReturnValue());
               console.log(response.getReturnValue());
               } else {
                             //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
               }
               });
               $A.enqueueAction(action);
        let getCast = component.get( "c.getMovieCast" );
        getCast.setParams({
                           movieId: movieId
                           });
        getCast.setCallback( this, function( response ) {
        if ( component.isValid() && response.getState() === 'SUCCESS' ) {
               component.set("v.actors", response.getReturnValue());
               console.log(response.getReturnValue());
               } else {
                             //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
               }
               });
               $A.enqueueAction(getCast);
    },

    MPHideMovieDetailEvent : function(component,event,handler){
                                  let display = event.getParam('display');
                                  component.set("v.displayedSection", display);
                                  },

    goBack : function(component,event,handler){
    component.set("v.displayedSection", false);
    let hide = $A.get("e.c:MPShowSearchComponentEvent");
                           hide.setParams({
                           "display" : true
                           });
                           hide.fire();
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
                console.log('home from movie detail');
                let hideReview = $A.get("e.c:MPHideReview");
                                                     hideReview.setParams({
                                                     "display" : false,
                                                     });
                                                     hideReview.fire();
                },

    getImages : function(component,event,handler){
        console.log('movie images');
        let movieId2 = component.get("v.movie").id;
        console.log(movieId2);

        let images = component.get( "c.getMovieImages" );
                images.setParams({
                                   movieId: movieId2
                                   });

                images.setCallback( this, function( response ) {
                if ( component.isValid() && response.getState() === 'SUCCESS' ) {
                       component.set("v.images", response.getReturnValue());
                       console.log(response.getReturnValue());
                       } else {
                                     //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                       }
                       });
                       $A.enqueueAction(images);
    },
    getVideos : function(component,event,handler){
        console.log('movie videos');
        let movieId2 = component.get("v.movie").id;
        let videos = component.get( "c.getMovieTrailers" );
                videos.setParams({
                                   movieId: movieId2
                                   });
                videos.setCallback( this, function( response ) {
                if ( component.isValid() && response.getState() === 'SUCCESS' ) {
                       component.set("v.videos", response.getReturnValue());
                       console.log(response.getReturnValue());
                       } else {
                                     //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                       }
                       });
                       $A.enqueueAction(videos);
    },

    addToFavorite : function(component,event,handler){
        let movieId = component.get("v.movie").id;
        let addToFB = component.get( "c.addToBFList" );
                        addToFB.setParams({
                                           movieId: movieId,
                                            FBType: 'Favorite'
                                           });
                        addToFB.setCallback( this, function( response ) {
                        if ( component.isValid() && response.getState() === 'SUCCESS' ) {
                               component.set("v.movie", response.getReturnValue());
                               console.log(response.getReturnValue());
                          } else {
                                             //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                          }
                         });
        $A.enqueueAction(addToFB);
    },

    addToBlacklist : function(component,event,handler){
       let movieId = component.get("v.movie").id;
        let addToFB = component.get( "c.addToBFList" );
                   addToFB.setParams({
                   movieId: movieId,
                  FBType: 'Black List'
                  });
             addToFB.setCallback( this, function( response ) {
             if ( component.isValid() && response.getState() === 'SUCCESS' ) {
              component.set("v.movie", response.getReturnValue());
           console.log(response.getReturnValue());
           } else {
             //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
          }
         });
        $A.enqueueAction(addToFB);
    }

})
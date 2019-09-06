({

    MPShowReviews : function(component,event,handler){
        let id = event.getParam("id");
        let context = event.getParam("context");
        let display = event.getParam("display");
        console.log('review inside --> ' + id + ' ' + context);
                let getReviews = component.get("c.getReviews");
                getReviews.setParams({
                      objectId: id,
                      context: context
                      });
                getReviews.setCallback( this, function( response ) {
                     if ( component.isValid() && response.getState() === 'SUCCESS' ) {
                        component.set("v.MovieReviews", response.getReturnValue());
                        console.log(response.getReturnValue());
                        } else {
                                             //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                               }
                               });
                     $A.enqueueAction(getReviews);
         },


})
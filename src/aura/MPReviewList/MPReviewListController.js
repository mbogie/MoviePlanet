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
                        console.log('ilosc -> ' + response.getReturnValue().length);
                        let sum = 0;
                        for (var i = 0; i < response.getReturnValue().length; i++) {
                        sum += response.getReturnValue()[i].Rating__c;
                        }
                        console.log('suma -> ' + sum);
                        let passReview = $A.get("e.c:MPPassAverageReviews");
                                passReview.setParams({
                                    "count": response.getReturnValue().length,
                                    "sum": sum
                                });
                                passReview.fire();
                        } else {
                                             //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
                               }
                               });
                     $A.enqueueAction(getReviews);
         },
})
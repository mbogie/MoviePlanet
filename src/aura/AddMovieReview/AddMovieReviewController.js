({
    doInit: function(component, event, helper) {
          //debugger
          helper.onInit(component, event,helper);
          },

    onSave : function(component, event, helper) {
        console.log('1');
           // debugger
    		let id = component.get("v.id");
            let context = component.get("v.context");
                    console.log('2 --> ' + id + ' ' + context);

            component.set("v.boatReview.Id__c", id);
                                console.log('3');

            component.set("v.boatReview.Type__c", context);
                    console.log('4');

            component.find("service").saveRecord(function(saveResult){
                if(saveResult.state==="SUCCESS" || saveResult.state === "DRAFT")
                {
                   let resultsToast = $A.get("e.force:showToast");
                    if(resultsToast)
                    {
                        resultsToast.setParams({
                            "title": "Saved",
                            "message": "Boat Review Created"
                        });
                        resultsToast.fire();
                    }
                    else
                    {
                        alert( 'Review Created');
                    }
                }
                else if (saveResult.state === "ERROR") {
                    let errMsg='';
                    console.log('Problem saving record, error: ' + JSON.stringify(saveResult.error));
                    for (let i = 0; i < saveResult.error.length; i++) {
                        errMsg += saveResult.error[i].message + "\n";
                    }
                    component.set("v.recordError", errMsg);
                }
                else
                {
                    console.log('Unknown problem, state: ' + saveResult.state + ', error: ' + JSON.stringify(saveResult.error));
                }
                 let showReviews = $A.get("e.c:MPShowReviews");
                        showReviews.setParams({
                            "id": id,
                            "display": true,
                            "context": context
                        });
                        showReviews.fire();
                helper.onInit(component,event,helper);
            });
    	},
        onRecordUpdated: function(component, event, helper) {
        }
})
({
    onInit: function (component, event, helper) {
        component.find("service").getNewRecord(
            "Movie__c", // sObject type (entityAPIName)
            null,      // recordTypeId
            false,     // skip cache?
            $A.getCallback(function () {
                let rec = component.get("v.newMovie");
                let error = component.get("v.recordError");
                if (error || (rec === null)) {
                    console.log("Error initializing record template: " + error);
                } else {
                    let test = component.get("v.newMovie");
                }
            })
        );
    },
})
({
    onInit: function (component, event, helper) {
      /*  component.find("service").getNewRecord(
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
        );*/
    },
    readFile: function(component, helper, file) {
            if (!file) return;
            if (!file.type.match(/(image.*)/)) {
      			return alert('Image file not supported');
    		}
            var reader = new FileReader();
            reader.onloadend = function() {
                var dataURL = reader.result;
                console.log(dataURL);
                component.set("v.pictureSrc", dataURL);
                helper.upload(component, file, dataURL.match(/,(.*)$/)[1]);
            };
            reader.readAsDataURL(file);
    	},

        upload: function(component, file, base64Data) {
            console.log('uploading photo');
            var action = component.get("c.saveAttachment");
            action.setParams({
                parentId: component.get("v.newMovieId"),
                fileName: file.name,
                base64Data: base64Data,
                contentType: file.type
            });
            action.setCallback(this, function(a) {
                component.set("v.message", "Image uploaded");
                        component.set("v.disabledAddButton", false);

            });
            component.set("v.message", "Uploading...");
            $A.enqueueAction(action);
        }
})
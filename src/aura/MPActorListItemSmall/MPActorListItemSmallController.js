({
    onSelect: function (component, event, helper) {
        let actorId = component.get("v.actor").id;
        console.log('actor pass1 ' + actorId);
        let action = $A.get("e.c:MPSelectedActorEvent");
        action.setParams({
            "actorId": actorId,
            "display": true
        });
        action.fire();
        console.log('actor pass2');
        let hideMovie = $A.get("e.c:MPHideMovieDetailEvent");
        hideMovie.setParams({
            "display": false
        });
        hideMovie.fire();
        let showReviews = $A.get("e.c:MPShowReviews");
        showReviews.setParams({
            "id": actorId,
            "display": true,
            "context": "Actor"
        });
        showReviews.fire();
        let hide = $A.get("e.c:MPHideSearchComponentEvent");
        hide.setParams({
            "display": false
        });
        hide.fire();
        console.log('after hideMovie');
    },
})
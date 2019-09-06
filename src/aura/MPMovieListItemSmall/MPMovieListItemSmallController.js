({
    doInit: function (component, event, helper) {
        let fbtype = component.get("v.movie").fbtype;
        console.log(fbtype === 'Black List');
        component.set("v.fbtype", fbtype);
    },

    onSelect: function (component, event, helper) {
        let hideMovie = $A.get("e.c:MPHideActorDetailEvent");
        hideMovie.setParams({
            "display": false
        });
        hideMovie.fire();
        let movieId = component.get("v.movie").id;
        let action = $A.get("e.c:MPSelectedMovieEvent");
        action.setParams({
            "movieId": movieId,
            "display": true
        });
        action.fire();
        let showReviews = $A.get("e.c:MPShowReviews");
        showReviews.setParams({
            "id": movieId,
            "display": true,
            "context": "Movie"
        });
        showReviews.fire();
        let hide = $A.get("e.c:MPHideSearchComponentEvent");
        hide.setParams({
            "display": false
        });
        hide.fire();
    },
})
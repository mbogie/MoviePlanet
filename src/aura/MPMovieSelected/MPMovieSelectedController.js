({
    MPSelectedMovieEvent: function (component, event, handler) {
        component.set("v.Spinner", true);
        component.set("v.selectedTabId", "one");
        component.set("v.movie", "{}");
        let movieId = event.getParam("movieId");
        let display = event.getParam('display');
        component.set("v.displayedSection", display);
        console.log('detail movie id ' + movieId)
        let action = component.get("c.getMovieDetail");
        action.setParams({
            movieId: movieId
        });
        action.setCallback(this, function (response) {
            if (component.isValid() && response.getState() === 'SUCCESS') {
                component.set("v.movie", response.getReturnValue());
                console.log(response.getReturnValue());
            } else {
                //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
            }
        });
        $A.enqueueAction(action);
        let getCast = component.get("c.getMovieCast");
        getCast.setParams({
            movieId: movieId
        });
        getCast.setCallback(this, function (response) {
            if (component.isValid() && response.getState() === 'SUCCESS') {
                component.set("v.actors", response.getReturnValue());
                console.log(response.getReturnValue());
            } else {
                //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
            }
        });
        $A.enqueueAction(getCast);
                       component.set("v.Spinner", false);

    },

    MPPassAverageReviews: function (component, event, handler) {
        let count = event.getParam("count");
        let sum = event.getParam("sum");
        let average = sum/count;
        console.log(sum + ' ' + count);
        if(sum >0){
        component.set("v.count", count);
        component.set("v.sum", average.toFixed(2));
        } else{
           component.set("v.count", 0);
           component.set("v.sum", 0);
        }
    },

    MPHideMovieDetailEvent: function (component, event, handler) {
        let display = event.getParam('display');
        component.set("v.displayedSection", display);
    },

    goBack: function (component, event, handler) {
        component.set("v.displayedSection", false);
        let hide = $A.get("e.c:MPShowSearchComponentEvent");
        hide.setParams({
            "display": true
        });
        hide.fire();
        let hideReview = $A.get("e.c:MPHideReview");
        hideReview.setParams({
            "display": false,
        });
        hideReview.fire();
    },

    goHome: function (component, event, handler) {
        component.set("v.displayedSection", false);
        let showHome = $A.get("e.c:MPSetHomePage");
        showHome.fire();
        console.log('home from movie detail');
        let hideReview = $A.get("e.c:MPHideReview");
        hideReview.setParams({
            "display": false,
        });
        hideReview.fire();
    },

    getImages: function (component, event, handler) {
        console.log('movie images');
        let movieId2 = component.get("v.movie").id;
        console.log(movieId2);

        let images = component.get("c.getMovieImages");
        images.setParams({
            movieId: movieId2
        });

        images.setCallback(this, function (response) {
            if (component.isValid() && response.getState() === 'SUCCESS') {
                component.set("v.images", response.getReturnValue());
                console.log(response.getReturnValue());
            } else {
                //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
            }
        });
        $A.enqueueAction(images);
    },
    getVideos: function (component, event, handler) {
        console.log('movie videos');
        let movieId2 = component.get("v.movie").id;
        let videos = component.get("c.getMovieTrailers");
        videos.setParams({
            movieId: movieId2
        });
        videos.setCallback(this, function (response) {
            if (component.isValid() && response.getState() === 'SUCCESS') {
                component.set("v.videos", response.getReturnValue());
                console.log(response.getReturnValue());
            } else {
                //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
            }
        });
        $A.enqueueAction(videos);
    },

    addToFavorite: function (component, event, handler) {
        let movieId = component.get("v.movie").id;
        let fbtype = component.get("v.movie").fbtype;
        let addToFB = component.get("c.addToBFList");
        addToFB.setParams({
            movieId: movieId,
            fbtype: 'Favorite'
        });
        addToFB.setCallback(this, function (response) {
            if (component.isValid() && response.getState() === 'SUCCESS') {
                if(fbtype == 'Favorite'){
                      component.set("v.movie.fbtype", null);

                }else{
                component.set("v.movie.fbtype", 'Favorite');
                }
                console.log(response.getReturnValue());
            } else {
                //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
            }
        });
        $A.enqueueAction(addToFB);
    },

    addToBlacklist: function (component, event, handler) {
        let movieId = component.get("v.movie").id;
                let fbtype = component.get("v.movie").fbtype;
        let addToFB = component.get("c.addToBFList");
        addToFB.setParams({
            movieId: movieId,
            fbtype: 'Black List'
        });
        addToFB.setCallback(this, function (response) {
            if (component.isValid() && response.getState() === 'SUCCESS') {
            if(fbtype == 'Black List'){
                      component.set("v.movie.fbtype", null);

                }else{
                component.set("v.movie.fbtype", 'Black List');
                }                console.log(response.getReturnValue());
            } else {
                //  component.find("toastCmp").showToastModel(response.getError()[0].message, "error");
            }
        });
        $A.enqueueAction(addToFB);
    }

})
public with sharing class MPSiteController {

    public static List<MPMovieWrapper.Production_companies> companiesString(List<String> stringList){
        List<MPMovieWrapper.Production_companies> companies = new List<MPMovieWrapper.Production_companies>();
        for(String s : stringList){
            MPMovieWrapper.Production_companies com = new MPMovieWrapper.Production_companies();
            com.name = s;
            companies.add(com);
        }
        return companies;
    }

    public static List<MPMovieWrapper.Genres> genresString(List<String> stringList){
        List<MPMovieWrapper.Genres> genres = new List<MPMovieWrapper.Genres>();
        for(String s : stringList){
            MPMovieWrapper.Genres com = new MPMovieWrapper.Genres();
            com.name = s;
            genres.add(com);
        }
        return genres;
    }
//public static String movieId = '458156';
    @AuraEnabled
    public static MPMovieWrapper getMovieDetail(String movieId) {
        if(movieId.length() < 10) {
            MPMovieWrapper movie = MPRestController.getMovieById(movieId);
            movie.source = 'external';
            List<Favorited_And_Blacklisted__c> oldList = [Select MovieId__c, Type__c FROM Favorited_And_Blacklisted__c WHERE User__c = :UserInfo.getUserId()];
            for (Favorited_And_Blacklisted__c fb : oldList) {
                if (movie.id == fb.MovieId__c) {
                    movie.FBType = fb.Type__c;
                }
            }
            return movie;
        } else {
            Movie__c internalMovie = [SELECT Budget__c, Genres__c, Homepage__c, Id, Name, Overview__c, Poster_path__c, Production_companies__c, Release_date__c, Runtime__c FROM Movie__c WHERE Id = :movieId];
            MPMovieWrapper movie = new MPMovieWrapper();
            movie.budget = internalMovie.Budget__c;
            movie.genres = genresString(internalMovie.Genres__c.split(';'));
            movie.homepage = internalMovie.Homepage__c;
            movie.id = internalMovie.Id;
            movie.overview = internalMovie.Overview__c;
            movie.poster_path = internalMovie.Poster_path__c;
            movie.production_companies = companiesString(internalMovie.Production_companies__c.split(','));
            movie.release_date = internalMovie.Release_date__c;
            movie.runtime = internalMovie.Runtime__c;
            movie.title = internalMovie.Name;
            movie.source = 'internal';
            return movie;
        }

    }
    @AuraEnabled
    public static List<MPCastAndCrewWrapper.Cast_Z> getMovieCast(String movieId) {
        List<MPCastAndCrewWrapper.Cast_Z> castList = MPRestController.getMovieCast(movieId);
        return castList;
    }
    @AuraEnabled
    public static List<MPMovieImagesWrapper.Backdrops> getMovieImages(String movieId) {
        List<MPMovieImagesWrapper.Backdrops> images = MPRestController.getMovieImages(movieId);
        return images;
    }
    @AuraEnabled
    public static List<MPMovieVideosWrapper.Trailer> getMovieTrailers(String movieId) {
        List<MPMovieVideosWrapper.Trailer> trailers = MPRestController.getMovieVideos(movieId);
        return trailers;
    }

//public static String actorId = '3894';
    @AuraEnabled
    public static MPActorWrapper getActorDetail(String actorId) {
        MPActorWrapper actor = MPRestController.getActorById(actorId);
        return actor;
    }
    @AuraEnabled
    public static List<MPActorFilmographyWrapper.Cast_Z> getActorFilmography(String actorId) {
        List<MPActorFilmographyWrapper.Cast_Z> filmography = MPRestController.getActorFilmography(actorId);
        return filmography;
    }
    @AuraEnabled
    public static List<MPActorImagesWrapper.Images> getActorImages(String actorId) {
        List<MPActorImagesWrapper.Images> images = MPRestController.getActorImages(actorId);
        return images;
    }

//rest
    @AuraEnabled
    public static List<MPPopularMoviesWrapper.PopularMovies> getPopularMovies() {
        List<MPPopularMoviesWrapper.PopularMovies> popularMovies = MPRestController.getPopularFilms();
        List<Favorited_And_Blacklisted__c> bfList = [SELECT MovieId__c, Type__c, User__c FROM Favorited_And_Blacklisted__c WHERE User__c = :UserInfo.getUserId()];
        for (MPPopularMoviesWrapper.PopularMovies p : popularMovies) {
            p.source = 'external';
            for (Favorited_And_Blacklisted__c item : bfList) {
                if (p.id == item.MovieId__c) p.FBType = item.Type__c;
            }
        }
        return popularMovies;
    }
    public static void getGenres() {
        List<MPGenreWrapper.Genres> genres = MPRestController.getGenres();
        for (MPGenreWrapper.Genres g : genres) {
            System.debug(g);
        }
    }

//public static String query = 'nicholson';
    @AuraEnabled
    public static MPMovieSearchWrapper searchMovies(String query, Integer page) {
        MPMovieSearchWrapper movies = MPRestController.searchMovies(query, page);
        List<Favorited_And_Blacklisted__c> bfList = [SELECT MovieId__c, Type__c, User__c FROM Favorited_And_Blacklisted__c WHERE User__c = :UserInfo.getUserId()];
        for (MPMovieSearchWrapper.Movies w : movies.results) {
            w.source = 'external';
            for (Favorited_And_Blacklisted__c item : bfList) {
                if (w.id == item.MovieId__c) w.FBType = item.Type__c;
            }
        }
        if (page == movies.total_pages) {
            String stringQuery = 'SELECT Budget__c, Genres__c, Homepage__c, Id, Name, Overview__c, Poster_path__c, Production_companies__c, Release_date__c, Runtime__c FROM Movie__c WHERE Name LIKE \'%' + query + '%\'';
            List<Movie__c> internalMovies = Database.query(stringQuery);
            if (!internalMovies.isEmpty()) {
                for (Movie__c m : internalMovies) {
                    MPMovieSearchWrapper.Movies movie = new MPMovieSearchWrapper.Movies(m);
                    for (Favorited_And_Blacklisted__c item : bfList) {
                        if (movie.id == item.MovieId__c) movie.FBType = item.Type__c;
                    }
                    movies.results.add(movie);
                }
            }
        }
        return movies;
    }

    @AuraEnabled
    public static MPActorSearchWrapper searchActors(String query, Integer page) {
        MPActorSearchWrapper actors = MPRestController.searchActors(query, page);
        return actors;
    }

    @AuraEnabled
    public static List<Review__c> getReviews(String objectId, String context) {
        List<Review__c> reviews = [SELECT Id, Name, Comment__c, Rating__c, LastModifiedDate, CreatedDate,CreatedBy.Name,CreatedBy.SmallPhotoUrl FROM Review__c WHERE Id__c = :objectId AND Type__c LIKE :context];
        return reviews;
    }

    @AuraEnabled
    public static MPMovieWrapper addToBFList(String movieId, String FBType) {
        String oldType = '';
        MPMovieWrapper movie = MPRestController.getMovieById(movieId);
        List<Favorited_And_Blacklisted__c> oldList = [Select Id,Type__c FROM Favorited_And_Blacklisted__c WHERE User__c = :UserInfo.getUserId() AND MovieId__c = :movieId];
        if (!oldList.isEmpty()) {
            oldType = oldList.get(0).Type__c;
            delete oldList;
        }
        if (oldType != FBType || oldList.isEmpty()) {
            Favorited_And_Blacklisted__c newObject = new Favorited_And_Blacklisted__c();
            newObject.Type__c = FBType;
            newObject.User__c = UserInfo.getUserId();
            newObject.MovieId__c = movieId;
            insert newObject;
            movie.FBType = FBType;
        }
        return movie;
    }

    @AuraEnabled
    public static void addMovie(String movie) {
        Movie__c newMovie = (Movie__c) JSON.deserialize(movie, Movie__c.class);
        List<Movie__c> oldMovies = [SELECT Name, Budget__c, Release_date__c FROM Movie__c WHERE Name LIKE :newMovie.Name];
        if (!oldMovies.isEmpty()) {
            throw new AuraHandledException('The Movie with title ' + newMovie.Name + ' already exists');
        } else {
            insert newMovie;
        }
    }

    @AuraEnabled
    public static BFlist getBF() {
        List<Favorited_And_Blacklisted__c> bfList = [SELECT MovieId__c, Type__c, User__c FROM Favorited_And_Blacklisted__c WHERE User__c = :UserInfo.getUserId()];
        if (bfList.isEmpty()) return null;
        BFlist bf = new BFlist();
        List<MPMovieWrapper> favorite = new List<MPMovieWrapper>();
        List<MPMovieWrapper> blacklist = new List<MPMovieWrapper>();
        for (Favorited_And_Blacklisted__c item : bfList) {
            MPMovieWrapper movie = MPRestController.getMovieById(item.MovieId__c);
            movie.FBType = item.Type__c;
            if (item.Type__c == 'Favorite') favorite.add(movie);
            if (item.Type__c == 'Black List') blacklist.add(movie);
        }
        bf.blacklist = blacklist;
        bf.favorite = favorite;
        System.debug(bf.favorite);
        System.debug(bf.blacklist);
        return bf;
    }

    public class BFlist {
        @AuraEnabled public List<MPMovieWrapper> favorite;
        @AuraEnabled public List<MPMovieWrapper> blacklist;
    }
}
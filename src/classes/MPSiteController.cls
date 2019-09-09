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
                    movie.fbtype = fb.Type__c;
                }
            }
            return movie;
        } else {
            Movie__c internalMovie = [SELECT Budget__c, Genres__c, Homepage__c, Id, Name, Overview__c, Poster_path__c, Production_companies__c, Release_date__c, Runtime__c FROM Movie__c WHERE Id = :movieId];
            List<Attachment> photo = [SELECT Id, Name FROM Attachment where parentid = :movieId];
            System.debug(internalMovie);
            MPMovieWrapper movie = new MPMovieWrapper();
            if(String.isNotBlank(internalMovie.Budget__c)) movie.budget = internalMovie.Budget__c;
            if(String.isNotBlank(internalMovie.Genres__c)) movie.genres = genresString(internalMovie.Genres__c.split(';'));
            if(String.isNotBlank(internalMovie.Homepage__c)) movie.homepage = internalMovie.Homepage__c;
            movie.id = internalMovie.Id;
            if(String.isNotBlank(internalMovie.Overview__c)) movie.overview = internalMovie.Overview__c;
            if(!photo.isEmpty()) movie.poster_path ='/servlet/servlet.FileDownload?file='+photo.get(0).Id;
            if(String.isNotBlank(internalMovie.Production_companies__c)) movie.production_companies = companiesString(internalMovie.Production_companies__c.split(','));
            if(internalMovie.Release_date__c != null) movie.release_date = internalMovie.Release_date__c;
            if(internalMovie.Runtime__c != null) movie.runtime = internalMovie.Runtime__c;
            movie.title = internalMovie.Name;
            movie.source = 'internal';
          //  System.debug(movie.poster_path + ' - --- ' + photo.Id);
            System.debug(movie);
            List<Favorited_And_Blacklisted__c> oldList = [Select MovieId__c, Type__c FROM Favorited_And_Blacklisted__c WHERE User__c = :UserInfo.getUserId()];
            for (Favorited_And_Blacklisted__c fb : oldList) {
                if (movie.id == fb.MovieId__c) {
                    movie.fbtype = fb.Type__c;
                }
            }
            return movie;
        }

    }
    @AuraEnabled
    public static List<MPCastAndCrewWrapper.Cast_Z> getMovieCast(String movieId) {
        try {
            List<MPCastAndCrewWrapper.Cast_Z> castList = MPRestController.getMovieCast(movieId);
            return castList;
        }catch(Exception e){
            return new List<MPCastAndCrewWrapper.Cast_Z>();
        }
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
        List<Favorited_And_Blacklisted__c> bfList = [SELECT MovieId__c, Type__c, User__c FROM Favorited_And_Blacklisted__c WHERE User__c = :UserInfo.getUserId()];
        for(MPActorFilmographyWrapper.Cast_Z c : filmography){
            c.source = 'external';
            for (Favorited_And_Blacklisted__c item : bfList) {
                if (c.id == item.MovieId__c) c.fbtype = item.Type__c;
            }
        }
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
                if (p.id == item.MovieId__c) p.fbtype = item.Type__c;
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
        System.debug('query --> ' + query);
        MPMovieSearchWrapper movies = MPRestController.searchMovies(query, page);
        List<Favorited_And_Blacklisted__c> bfList = [SELECT MovieId__c, Type__c, User__c FROM Favorited_And_Blacklisted__c WHERE User__c = :UserInfo.getUserId()];
        for (MPMovieSearchWrapper.Movies w : movies.results) {
            w.source = 'external';
            for (Favorited_And_Blacklisted__c item : bfList) {
                if (w.id == item.MovieId__c) w.fbtype = item.Type__c;
            }
        }
        System.debug(page + ' <----> ' + movies.total_pages);
        if (page == movies.total_pages || movies.total_pages == 0) {
            System.debug('internal search');
            String stringQuery = 'SELECT Budget__c, Genres__c, Homepage__c, Id, Name, Overview__c, Poster_path__c, Production_companies__c, Release_date__c, Runtime__c FROM Movie__c WHERE IsVisible__c = true AND Name LIKE \'%' + query + '%\'';
            List<Movie__c> internalMovies = Database.query(stringQuery);
            if (!internalMovies.isEmpty()) {
                for (Movie__c m : internalMovies) {
                    MPMovieSearchWrapper.Movies movie = new MPMovieSearchWrapper.Movies(m);
                    for (Favorited_And_Blacklisted__c item : bfList) {
                        if (movie.id == item.MovieId__c) movie.fbtype = item.Type__c;
                    }
                    List<Attachment> photo = [SELECT Id, Name FROM Attachment where parentid = :m.Id];
                    if(!photo.isEmpty()) movie.poster_path ='/servlet/servlet.FileDownload?file='+photo.get(0).Id;
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
    public static MPMovieWrapper addToBFList(String movieId, String fbtype) {
        String oldType = '';
        System.debug(fbtype);
       /* if(movieId.length()<10) {
            MPMovieWrapper movie = MPRestController.getMovieById(movieId);
        } else {
            Movie__c internalMovie = [SELECT Id, ]
        }*/
        List<Favorited_And_Blacklisted__c> oldList = [Select Id,Type__c FROM Favorited_And_Blacklisted__c WHERE User__c = :UserInfo.getUserId() AND MovieId__c = :movieId];
        if (!oldList.isEmpty()) {
            oldType = oldList.get(0).Type__c;
            delete oldList;
        }
        if (oldType != fbtype || oldList.isEmpty()) {
            Favorited_And_Blacklisted__c newObject = new Favorited_And_Blacklisted__c();
            newObject.Type__c = fbtype;
            newObject.User__c = UserInfo.getUserId();
            newObject.MovieId__c = movieId;
            insert newObject;
       //     movie.fbtype = fbtype;
        }
        return null;
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
    public static String getMovieId(Movie__c movie) {
        System.debug('title - ' + movie);
        Database.SaveResult saveResult = Database.insert(movie);
        if(saveResult.isSuccess()){
            return saveResult.id;
        } else {
            throw new AuraHandledException('The Movie can\'t be created');
        }
//        List<Movie__c> newMovie = [SELECT Id FROM Movie__c WHERE Name LIKE :title];
//        System.debug(newMovie);
//        if (newMovie.isEmpty()) {
//            throw new AuraHandledException('The Movie can\'t be created');
//        } else {
//            return newMovie[0].Id;
//        }
 //       return null;
    }

    @AuraEnabled
    public static String checkMovieInside(String movie) {
        String title = movie;
        System.debug('title ' + movie);
        if(String.isNotBlank(movie)) {
            List<Movie__c> oldMovies = [SELECT Name, Budget__c, Release_date__c FROM Movie__c WHERE Name LIKE :title];
            if (!oldMovies.isEmpty()) {
                throw new AuraHandledException('The Movie with title ' + title + ' already exists');
            } else {
                return 'Movie with title: ' + title + ' can be created';
            }
        } else {
            return null;
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
            if(item.MovieId__c.length()<10) {
                MPMovieWrapper movie = MPRestController.getMovieById(item.MovieId__c);
                movie.source = 'external';
                movie.fbtype = item.Type__c;
                if (item.Type__c == 'Favorite') favorite.add(movie);
                if (item.Type__c == 'Black List') blacklist.add(movie);
            } else {
                Movie__c internalMovie = [SELECT Budget__c, Genres__c, Homepage__c, Id, Name, Overview__c, Poster_path__c, Production_companies__c, Release_date__c, Runtime__c FROM Movie__c WHERE Id = :item.MovieId__c];
                List<Attachment> photo = [SELECT Id, Name FROM Attachment where parentid = :item.MovieId__c];
                System.debug(internalMovie);
                MPMovieWrapper movie = new MPMovieWrapper();
                movie.id = internalMovie.Id;
                if(!photo.isEmpty()) movie.poster_path ='/servlet/servlet.FileDownload?file='+photo.get(0).Id;
                movie.title = internalMovie.Name;
                movie.source = 'internal';
                //  System.debug(movie.poster_path + ' - --- ' + photo.Id);
                movie.fbtype = item.Type__c;
                if (item.Type__c == 'Favorite') favorite.add(movie);
                if (item.Type__c == 'Black List') blacklist.add(movie);
            }
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

    @AuraEnabled
    public static Attachment getProfilePicture(Id parentId) {

        // Attachment permissions are set in parent object (Contact)
        if (!Schema.sObjectType.Contact.isAccessible()) {
            throw new System.NoAccessException();
            //return null;
        }

        return [SELECT Id, Name, LastModifiedDate, ContentType FROM Attachment
        WHERE parentid=:ParentId AND ContentType IN ('image/png', 'image/jpeg', 'image/gif')
        ORDER BY LastModifiedDate DESC LIMIT 1];
    }

    @AuraEnabled
    public static Id saveAttachment(Id parentId, String fileName, String base64Data, String contentType) {
        System.debug('zapisuje');
        // Edit permission on parent object (Contact) is required to add attachments
        if (!Schema.sObjectType.Contact.isUpdateable()) {
            throw new System.NoAccessException();
          //  return null;
        }

        Attachment attachment = new Attachment();
        attachment.parentId = parentId;
        attachment.body = EncodingUtil.base64Decode(base64Data);
        attachment.name = fileName;
        attachment.contentType = contentType;
        insert attachment;
        return attachment.id;
    }
}
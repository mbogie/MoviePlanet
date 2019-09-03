public with sharing class MPSiteController {

//public static String movieId = '458156';
    @AuraEnabled
    public static MPMovieWrapper getMovieDetail(String movieId) {
        MPMovieWrapper movie = MPRestController.getMovieById(movieId);
        return movie;
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
    public static void getMovieTrailers(String movieId) {
        List<MPMovieVideosWrapper.Trailer> trailers = MPRestController.getMovieVideos(movieId);
        for (MPMovieVideosWrapper.Trailer t : trailers) {
            System.debug(t);
        }
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
    public static void getActorImages(String actorId) {
        List<MPActorImagesWrapper.Images> images = MPRestController.getActorImages(actorId);
        for (MPActorImagesWrapper.Images i : images) {
            System.debug(i);
        }
    }

//rest
    @AuraEnabled
    public static List<MPPopularMoviesWrapper.PopularMovies> getPopularMovies() {
        List<MPPopularMoviesWrapper.PopularMovies> popularMovies = MPRestController.getPopularFilms();
        return popularMovies;
    }
    public static void getGenres(){
        List<MPGenreWrapper.Genres> genres = MPRestController.getGenres();
        for(MPGenreWrapper.Genres g : genres){
            System.debug(g);
        }
    }

//public static String query = 'nicholson';
    @AuraEnabled
    public static List<MPMovieSearchWrapper.Movies> searchMovies(String query){
        List<MPMovieSearchWrapper.Movies> movies = MPRestController.searchMovies(query);
        return movies;
    }

    @AuraEnabled
    public static List<MPActorSearchWrapper.Actors> searchActors(String query){
        List<MPActorSearchWrapper.Actors> actors = MPRestController.searchActors(query);
        return actors;
    }
}
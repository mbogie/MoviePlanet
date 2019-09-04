public with sharing class MPRestController {

    public static String MOVIE_DB_API_KEY = MPUtils.getCsValues('movieDbApiKey');
    public static String MOVIE_DB_URL = MPUtils.getCsValues('movieDbApiUrl');

    public static String getDbValues(String endpoint) {
        System.debug(endpoint);
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = new Http().send(request);
        if (response.getStatusCode() == 200) {
            return response.getBody();
        } else throw new MpException(response.getStatusCode() + ' ' + response.getStatus());
    }

    public static MPMovieWrapper getMovieById(String movieId) {
        String endpoint = MOVIE_DB_URL + '/movie/' + movieId + '?' + MOVIE_DB_API_KEY;
        String jsonString = getDbValues(endpoint);
        MPMovieWrapper movieWrapper = (MPMovieWrapper) System.JSON.deserialize(jsonString, MPMovieWrapper.class);
        return movieWrapper;
    }

    public static MPActorWrapper getActorById(String actorId) {
        String endpoint = MOVIE_DB_URL + '/person/' + actorId + '?' + MOVIE_DB_API_KEY;
        String jsonString = getDbValues(endpoint);
        MPActorWrapper actorWrapper = (MPActorWrapper) System.JSON.deserialize(jsonString, MPActorWrapper.class);
        return actorWrapper;
    }

    public static List<MPCastAndCrewWrapper.Cast_Z> getMovieCast(String movieId) {
        String endpoint = MOVIE_DB_URL + '/movie/' + movieId + '/credits?' + MOVIE_DB_API_KEY;
        String jsonString = getDbValues(endpoint);
        System.JSONParser parser = System.JSON.createParser(jsonString);
        MPCastAndCrewWrapper crewWrapper = new MPCastAndCrewWrapper(parser);
        return crewWrapper.cast_Z;
    }

    public static List<MPActorFilmographyWrapper.Cast_Z> getActorFilmography(String actorId) {
        String endpoint = MOVIE_DB_URL + '/person/' + actorId + '/movie_credits?' + MOVIE_DB_API_KEY;
        String jsonString = getDbValues(endpoint);
        System.JSONParser parser = System.JSON.createParser(jsonString);
        MPActorFilmographyWrapper actorFilmographyWrapper = new MPActorFilmographyWrapper(parser);
        return actorFilmographyWrapper.cast_Z;
    }

    public static List<MPActorImagesWrapper.Images> getActorImages(String actorId){
        String endpoint = MOVIE_DB_URL + '/person/' + actorId + '/images?' + MOVIE_DB_API_KEY;
        String jsonString = getDbValues(endpoint);
        MPActorImagesWrapper images = (MPActorImagesWrapper) System.JSON.deserialize(jsonString, MPActorImagesWrapper.class);
        return images.profiles;
    }

    public static List<MPPopularMoviesWrapper.PopularMovies> getPopularFilms() {
        String endpoint = MOVIE_DB_URL + '/movie/popular?' + MOVIE_DB_API_KEY;
        String jsonString = getDbValues(endpoint);
        MPPopularMoviesWrapper popularMoviesWrapper = (MPPopularMoviesWrapper) System.JSON.deserialize(jsonString, MPPopularMoviesWrapper.class);
        return popularMoviesWrapper.results;
    }

    public static List<MPGenreWrapper.Genres> getGenres() {
        String endpoint = MOVIE_DB_URL + '/genre/movie/list?' + MOVIE_DB_API_KEY;
        String jsonString = getDbValues(endpoint);
        MPGenreWrapper genresWrapper = (MPGenreWrapper) System.JSON.deserialize(jsonString, MPGenreWrapper.class);
        return genresWrapper.genres;
    }

    public static MPMovieSearchWrapper searchMovies(String query, integer page) {
        String endpoint = MOVIE_DB_URL + '/search/movie?' + MOVIE_DB_API_KEY + '&query=' + query +'&page=' + page ;
        String jsonString = getDbValues(endpoint);
        MPMovieSearchWrapper movieSearchWrapper = (MPMovieSearchWrapper) System.JSON.deserialize(jsonString, MPMovieSearchWrapper.class);
        return movieSearchWrapper;
    }

    public static MPActorSearchWrapper searchActors(String query, Integer page) {
        String endpoint = MOVIE_DB_URL + '/search/person?' + MOVIE_DB_API_KEY + '&query=' + query +'&page=' + page ;
        String jsonString = getDbValues(endpoint);
        MPActorSearchWrapper actorSearchWrapper = (MPActorSearchWrapper) System.JSON.deserialize(jsonString, MPActorSearchWrapper.class);
        return actorSearchWrapper;
}

    public static List<MPMovieImagesWrapper.Backdrops> getMovieImages(String movieId) {
        String endpoint = MOVIE_DB_URL + '/movie/' + movieId + '/images?' + MOVIE_DB_API_KEY;
        String jsonString = getDbValues(endpoint);
        MPMovieImagesWrapper movieImagesWrapper = (MPMovieImagesWrapper) System.JSON.deserialize(jsonString, MPMovieImagesWrapper.class);
        return movieImagesWrapper.backdrops;
    }

    public static List<MPMovieVideosWrapper.Trailer> getMovieVideos(String movieId) {
        String endpoint = MOVIE_DB_URL + '/movie/' + movieId + '/videos?' + MOVIE_DB_API_KEY;
        String jsonString = getDbValues(endpoint);
        MPMovieVideosWrapper movieVideosWrapper = (MPMovieVideosWrapper) System.JSON.deserialize(jsonString, MPMovieVideosWrapper.class);
        return movieVideosWrapper.results;
    }
}
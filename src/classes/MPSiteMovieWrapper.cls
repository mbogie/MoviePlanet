public with sharing class MPSiteMovieWrapper {

    public String budget;
    public String genres;
    public String homepage;
    public String id;
    public String overview;
    public String poster_path;
    public String production_companies;
    public Date release_date;
    public Decimal runtime;
    public String title;
    public String source;
    public String character;

    public MPSiteMovieWrapper(MPMovieWrapper movieWrapper){
        this.source = 'external';
        this.budget = movieWrapper.budget;
        this.genres = genresString(movieWrapper.genres);
        this.homepage = movieWrapper.homepage;
        this.id = movieWrapper.id;
        this.overview = movieWrapper.overview;
        this.poster_path = movieWrapper.poster_path;
        this.production_companies = companiesString(movieWrapper.production_companies);
        this.release_date = movieWrapper.release_date;
        this.runtime = movieWrapper.runtime;
        this.title = movieWrapper.title;
    }

    public MPSiteMovieWrapper(Movie__c movie){
        this.source = 'internal';
        this.budget = movie.Budget__c;
        this.genres = movie.Genres__c;
        this.homepage = movie.Homepage__c;
        this.id = movie.Id;
        this.overview = movie.Overview__c;
        this.poster_path = movie.Poster_path__c;
        this.production_companies = movie.Production_companies__c;
        this.release_date = movie.Release_date__c;
        this.runtime = movie.Runtime__c;
        this.title = movie.Name;
    }

    public MPSiteMovieWrapper(MPMovieSearchWrapper.Movies movie){
        this.source = 'external';
        this.id = movie.id;
        this.title = movie.title;
        this.poster_path = movie.poster_path;
    }

    public MPSiteMovieWrapper(MPActorFilmographyWrapper.Cast_Z movie){
        this.source = 'external';
        this.id = movie.id;
        this.title = movie.title;
        this.poster_path = movie.poster_path;
        this.character = movie.character;
    }

    public String companiesString(List<MPMovieWrapper.Production_companies> companiesList){
        String companies = '';
        for(MPMovieWrapper.Production_companies p : companiesList){
            companies += p.name + ', ';
        }
        return companies.removeEnd(', ');
    }

    public String genresString(List<MPMovieWrapper.Genres> genresList){
        String genresString = '';
        for ( MPMovieWrapper.Genres g : genresList){
            genresString += g.name + ', ';
        }
        return genresString.removeEnd(', ');
    }
}
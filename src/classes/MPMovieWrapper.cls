public class MPMovieWrapper {

//    public Boolean adult;
//    public String backdrop_path;
//    public Belongs_to_collection belongs_to_collection;
//    public String imdb_id;
//    public String original_language;
//    public String original_title;
//    public Double popularity;
//    public List<Production_countries> production_countries;
//    public Integer revenue;
//    public List<Spoken_languages> spoken_languages;
//    public String status;
//    public String tagline;
//    public Boolean video;
//    public Double vote_average;
//    public Integer vote_count;

    @AuraEnabled public String budget;
    @AuraEnabled public List<Genres> genres;
    @AuraEnabled public String homepage;
    @AuraEnabled public String id;
    @AuraEnabled public String overview;
    @AuraEnabled public String poster_path;
    @AuraEnabled public List<Production_companies> production_companies;
    @AuraEnabled public Date release_date;
    @AuraEnabled public Decimal runtime;
    @AuraEnabled public String title;

    public class Production_companies {
        @AuraEnabled public Integer id;
        @AuraEnabled public String logo_path;
        @AuraEnabled public String name;
        @AuraEnabled public String origin_country;
    }

    public class Genres {
        @AuraEnabled public Integer id;
        @AuraEnabled public String name;
    }
}
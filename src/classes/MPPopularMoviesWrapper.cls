public class MPPopularMoviesWrapper {

    public class PopularMovies {
        @AuraEnabled public String poster_path;
        @AuraEnabled public String id;
        @AuraEnabled public String title;
        @AuraEnabled public String source;
        @AuraEnabled public String FBType;

    }

    @AuraEnabled public Integer page;
    @AuraEnabled public Integer total_results;
    @AuraEnabled public Integer total_pages;
    @AuraEnabled public List<PopularMovies> results;
}
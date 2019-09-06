public class MPMovieSearchWrapper {

    @AuraEnabled public Integer page;
    @AuraEnabled public Integer total_results;
    @AuraEnabled public Integer total_pages;
    @AuraEnabled public List<Movies> results;

    public class Movies {
//        public Double popularity;
        @AuraEnabled public String id;
//        public Boolean video;
//        public Integer vote_count;
//        public Double vote_average;
        @AuraEnabled public String title;
//        public String release_date;
//        public String original_language;
//        public String original_title;
//        public String backdrop_path;
//        public Boolean adult;
//        public String overview;
        @AuraEnabled public String poster_path;
        @AuraEnabled public String source;
        @AuraEnabled public String fbtype;

        public Movies(Movie__c movie){
            id = movie.Id;
            title = movie.Name;
            poster_path = movie.Poster_path__c;
            source = 'internal';
        }
    }
}
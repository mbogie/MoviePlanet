public class MPMovieSearchWrapper {

    public Integer page;
    public Integer total_results;
    public Integer total_pages;
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
    }
}
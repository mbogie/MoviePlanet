public class MPMovieVideosWrapper {

    public Integer id;
    @AuraEnabled public List<Trailer> results;

    public class Trailer {
      //  public String id;
      //  public String iso_639_1;
     //   public String iso_3166_1;
        @AuraEnabled public String key;
        @AuraEnabled public String name;
        @AuraEnabled public String site;
     //   public Integer size;
    }
}
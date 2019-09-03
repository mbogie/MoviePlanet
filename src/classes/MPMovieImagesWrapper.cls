public class MPMovieImagesWrapper {

    public Integer id;
    @AuraEnabled public List<Backdrops> backdrops;
    @AuraEnabled public List<Posters> posters;

    public class Backdrops {
      //  public Double aspect_ratio;
        @AuraEnabled public String file_path;
      //  public Integer height;
      //  public String iso_639_1;
     //   public Double vote_average;
      //  public Integer vote_count;
     //   public Integer width;
    }

    public class Posters {
      //  public Double aspect_ratio;
        @AuraEnabled public String file_path;
     //   public Integer height;
      //  public String iso_639_1;
      //  public Double vote_average;
     //   public Integer vote_count;
      //  public Integer width;
    }
}
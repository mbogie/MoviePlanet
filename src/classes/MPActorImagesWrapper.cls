public class MPActorImagesWrapper {

    @AuraEnabled public List<Images> profiles;
    public Integer id;

    public class Images {
        @AuraEnabled public String file_path;
    }

}
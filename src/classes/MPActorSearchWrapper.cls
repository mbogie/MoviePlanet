public class MPActorSearchWrapper {

    public Integer page;
    public Integer total_results;
    public Integer total_pages;
    @AuraEnabled public List<Actors> results;

    public class Actors {
        @AuraEnabled public String known_for_department;
        @AuraEnabled public String name;
        @AuraEnabled public String id;
        @AuraEnabled public String profile_path;
    }
}
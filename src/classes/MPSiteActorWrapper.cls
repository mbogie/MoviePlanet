public with sharing class MPSiteActorWrapper {

    public Date birthday;
    public Date deathday;
    public String id;
    public String name;
    public String also_known_as;
    public String biography;
    public String place_of_birth;
    public String profile_path;
    public String source;
    public String character;

    public MPSiteActorWrapper(MPActorWrapper actorWrapper) {
        this.source = 'external';
        this.biography = actorWrapper.biography;
        this.deathday = actorWrapper.deathday;
        this.id = actorWrapper.id;
        this.name = actorWrapper.name;
        this.also_known_as = knowAsString(actorWrapper.also_known_as);
        this.birthday = actorWrapper.birthday;
        this.place_of_birth = actorWrapper.place_of_birth;
        this.profile_path = actorWrapper.profile_path;
    }

    public MPSiteActorWrapper(Actor__c actor) {
        this.source = 'internal';
        this.biography = actor.Biography__c;
        this.deathday = actor.Deathday__c;
        this.id = actor.Id;
        this.name = actor.Name;
        this.also_known_as = actor.Known_as__c;
        this.birthday = actor.Birthday__c;
        this.place_of_birth = actor.Place_of_birth__c;
        this.profile_path = actor.Profile_path__c;
    }

    public MPSiteActorWrapper(MPActorSearchWrapper.Actors actor){
        this.source = 'external';
        this.name = actor.name;
        this.id = actor.id;
        this.profile_path = actor.profile_path;
    }

    public MPSiteActorWrapper(MPCastAndCrewWrapper.Cast_Z actor) {
        this.source = 'external';
        this.name = actor.name;
        this.id = actor.id;
        this.profile_path = actor.profile_path;
        this.character = actor.character;
    }

    public String knowAsString(List<String> stringList){
        String knowAs = '';
        for (String s : stringList){
            knowAs += s + ', ';
        }
        return knowAs.removeEnd(', ');
    }
}
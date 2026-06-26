public with sharing class UserController {
    
    @AuraEnabled(cacheable=true)
    public static String getProfileName() {
        Id profileId = [
            SELECT ProfileId 
            FROM User 
            WHERE Id = :UserInfo.getUserId()
        ].ProfileId;

        return[
            SELECT Name 
            FROM Profile 
            WHERE Id = :profileId]
        .Name;
        
    }
}
public with sharing class ImportWizardController {

    @AuraEnabled(cacheable=true)
    public static List<User> searchUsers(String searchText) {

        return [
            SELECT Id,
                   Name,
                   Email
            FROM User
            WHERE IsActive = true
            AND Name LIKE :('%' + searchText + '%')
            ORDER BY Name
            LIMIT 20
        ];
    }

    @AuraEnabled(cacheable=true)
    public static User getUserDetails(Id userId) {

        return [
            SELECT Id,
                   Name,
                   Email
            FROM User
            WHERE Id = :userId
            LIMIT 1
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Initiative__c> getInitiativesByUser(Id userId) {

        return [
            SELECT Id,
                   Name,
                   Phase__c,
                   Status__c,
                   Owner__r.Name
            FROM Initiative__c
            WHERE Owner__c = :userId
            ORDER BY Name
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Integer getInitiativeCount(Id userId) {

        return [
            SELECT Count()
            FROM Initiative__c
            WHERE Owner__c = :userId
        ];
    }
    
    
    
    
    //InitiativeManagerComp - apex method
    @AuraEnabled(cacheable=true)
    public static List<Initiative__c> getMyInitiatives() {

    return [
        SELECT Id,
               Name,
               Status__c,
               Owner__c,
               Owner__r.Name
        FROM Initiative__c
     //   WHERE Owner__c = :UserInfo.getUserId()
        ORDER BY Name
    ];
}
    
}
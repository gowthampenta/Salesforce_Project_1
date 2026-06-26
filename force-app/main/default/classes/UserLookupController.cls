public with sharing class UserLookupController {

    @AuraEnabled(cacheable=true)
    public static List<User> searchUsers(String searchText) {

        return [
            SELECT Id, Name, Email
            FROM User
            WHERE IsActive = true
            AND Name LIKE :('%' + searchText + '%')
            LIMIT 10
        ];
    }
}
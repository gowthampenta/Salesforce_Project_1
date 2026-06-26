public with sharing class AccountSearchController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccounts(String searchKey) {
        
        if(String.isBlank(searchKey)){
            return [
                SELECT Id, Name, Industry, Phone, Rating
                FROM Account
                LIMIT 10
            ];
        }
        
        return [
            SELECT Id, Name, Industry, Phone, Rating
            FROM Account
            WHERE Name LIKE :('%' + searchKey + '%')
            LIMIT 50
        ];
    }
}
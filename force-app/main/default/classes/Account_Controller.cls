public with sharing class Account_Controller {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts() {
        return [
            SELECT Id, Name
            FROM Account
            ORDER BY Name
        ];
    }

    @AuraEnabled
    public static void deleteAccount(Id accountId) {

        Account acc = [
            SELECT Id
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];

        delete acc;
    }
}
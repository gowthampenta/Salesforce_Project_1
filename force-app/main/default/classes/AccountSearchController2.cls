public with sharing class AccountSearchController2 {

    @AuraEnabled(cacheable=true)
    public static List<Account> searchAccounts(String searchKey, Integer limitSize, Integer offsetSize) {

        String query = 'SELECT Id, Name, Industry, Phone, Rating FROM Account';

        if(String.isNotBlank(searchKey)){
            query += ' WHERE Name LIKE \'%' + String.escapeSingleQuotes(searchKey) + '%\'';
        }

        query += ' ORDER BY Name LIMIT :limitSize OFFSET :offsetSize';

        return Database.query(query);
    }
}
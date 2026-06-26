public with sharing class PaginationController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getNextRecords(Id lastId, Integer limitSize) {

        if(lastId == null){
            return [
                SELECT Id, Name, Industry, Phone, Rating
                FROM Account
                ORDER BY Id
                LIMIT :limitSize
            ];
        } else {
            return [
                SELECT Id, Name, Industry, Phone, Rating
                FROM Account
                WHERE Id > :lastId
                ORDER BY Id
                LIMIT :limitSize
            ];
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getPreviousRecords(Id firstId, Integer limitSize) {

        return [
            SELECT Id, Name, Industry, Phone, Rating
            FROM Account
            WHERE Id < :firstId
            ORDER BY Id DESC
            LIMIT :limitSize
        ];
    }

}
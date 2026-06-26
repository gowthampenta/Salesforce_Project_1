public with sharing class AccountDetailController {

    @AuraEnabled
    public static void saveRecord(Id accId, String name, String description, Decimal amount, String status, Id recId) {

        try {
            Account_Detail__c rec;

            if(recId != null){
                rec = [SELECT Id FROM Account_Detail__c WHERE Id = :recId LIMIT 1];
                rec.Name = name;
                rec.Description__c = description;
                rec.Amount__c = amount;
                rec.Status__c = status;
                update rec;
            } else {
                rec = new Account_Detail__c(
                    Name = name,
                    Account_Lookup__c = accId,
                    Description__c = description,
                    Amount__c = amount,
                    Status__c = status
                );
                insert rec;
            }

        } catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Account_Detail__c> getRecords(Id accId){
        return [
            SELECT Id, Name, Description__c, Amount__c, Status__c
            FROM Account_Detail__c
            WHERE Account_Lookup__c = :accId
        ];
    }

    @AuraEnabled
    public static void deleteRecord(Id recId){
        delete [SELECT Id FROM Account_Detail__c WHERE Id = :recId LIMIT 1];
    }
}
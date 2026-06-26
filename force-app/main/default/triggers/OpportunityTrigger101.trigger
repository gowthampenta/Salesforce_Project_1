trigger OpportunityTrigger101 on Opportunity(after update) {

    Set<Id> accountIds = new Set<Id>();

    for(Opportunity opp : Trigger.new){

        Opportunity oldOpp = Trigger.oldMap.get(opp.Id);

        if(opp.StageName == 'Finalization'
           && oldOpp.StageName != 'Finalization'
           && opp.AccountId != null){

            accountIds.add(opp.AccountId);
        }
    }

    List<Account> accountsToUpdate = new List<Account>();

    for(Account acc : [
        SELECT Id, SAP__c
        FROM Account
        WHERE Id IN :accountIds
    ]){
        acc.SAP__c = 101;
        accountsToUpdate.add(acc);
    }

    update accountsToUpdate;
}
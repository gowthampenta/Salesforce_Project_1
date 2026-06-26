trigger ProductCountOnAccount on OpportunityLineItem (after insert, after delete, after update) {
    
    Set<Id> oppIds = new Set<Id>();
    
    if(Trigger.isInsert || Trigger.isUpdate){
        for(OpportunityLineItem oli : Trigger.new){
            oppIds.add(oli.OpportunityId);
        }
    }
    
    if(Trigger.isDelete){
        for(OpportunityLineItem oli : Trigger.old){
            oppIds.add(oli.OpportunityId);
        }
    }
    
    List<Account> accList = new List<Account>();
    
    List<Opportunity> oppList = [SELECT Id, AccountId FROM Opportunity WHERE Id IN :oppIds];
    
    for(Opportunity opp : oppList){
        
        Integer countVal = [SELECT COUNT() FROM OpportunityLineItem WHERE OpportunityId = :opp.Id];
        
        accList.add(new Account(Id = opp.AccountId,Total_Products__c = countVal));
    }
    
   
    update accList;
}
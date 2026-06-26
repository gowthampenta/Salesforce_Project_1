trigger OpportunityTrigger on Opportunity (after insert, after update, after delete, after undelete) {
   /*
    Set<Id> accIds = new Set<Id>();
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        for(Opportunity opp : trigger.new){
            accIds.add(opp.AccountId);
        }
    }
    
    if(Trigger.isUpdate || Trigger.isDelete){
        for(Opportunity opp : trigger.old){
            accIds.add(opp.AccountId);
        }
    }
    
    OpportunityHandler.updateClosedWonCount(accIds);
 */
}
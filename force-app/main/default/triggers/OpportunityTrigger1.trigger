trigger OpportunityTrigger1 on Opportunity (before delete) {
  if(Trigger.isBefore && Trigger.isDelete){
    DeletedRecordController.saveDeletedRecords(
        Trigger.old,
        'Opportunity'
    );  
  }
}
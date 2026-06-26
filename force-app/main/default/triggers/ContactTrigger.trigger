trigger ContactTrigger on Contact (before delete) {
   if(Trigger.isBefore && Trigger.isDelete){
    DeletedRecordController.saveDeletedRecords(
        Trigger.old,
        'Contact'
    );    
   }
}
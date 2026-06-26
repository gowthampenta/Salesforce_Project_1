trigger AccountTrigger1 on Account (before delete) {

    if(Trigger.isBefore && Trigger.isDelete){

        DeletedRecordController.saveDeletedRecords(
            Trigger.old,
            'Account'
        );
    }
}
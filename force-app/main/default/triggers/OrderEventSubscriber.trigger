trigger OrderEventSubscriber on Order_Created__e (after insert) {

    for(Order_Created__e evt : Trigger.New){

        System.enqueueJob(
            new SendOrderToWarehouse(
                evt.Order_Id__c,
                evt.Order_Number__c
            )
        );
    }
}
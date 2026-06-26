trigger OrderTrigger on Order (after insert) {
     
    List<Order_Created__e> events = new List<Order_Created__e>();

    for(Order ord : Trigger.new){

        events.add(
            new Order_Created__e(
                Order_Id__c = String.valueOf(ord.Id),
                Order_Number__c = ord.OrderNumber,
                Status__c = 'Created'
            )
        );
    }

    Database.SaveResult[] results = EventBus.publish(events);

    for(Database.SaveResult sr : results){
        if(!sr.isSuccess()){
            for(Database.Error err : sr.getErrors()){
                System.debug('ERROR: ' + err.getMessage());
            }
        }
    }
     // System.debug('Order Created --> Order Trigger is Working Fine');
}
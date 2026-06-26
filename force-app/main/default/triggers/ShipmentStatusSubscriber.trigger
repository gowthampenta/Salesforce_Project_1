trigger ShipmentStatusSubscriber on Shipment_Status__e (after insert) {

    System.debug('EVENT TRIGGER FIRED');

    List<Order> ordersToUpdate = new List<Order>();

    for(Shipment_Status__e evt : Trigger.New){

        System.debug('Order Id = ' + evt.OrderId__c);

        ordersToUpdate.add(
            new Order(
                Id = evt.OrderId__c,
                Order_Status__c  = 'Shipped Awaiting Invoice !!'
            )
        );
    }

    if(!ordersToUpdate.isEmpty()){

        try{
          //  update ordersToUpdate;
            System.debug('ORDER UPDATED');
        }
        catch(Exception e){
            System.debug('ERROR = ' + e.getMessage());
        }
    }
}
@RestResource(urlMapping='/shipmentstatus')
global with sharing class ShipmentStatusAPI { // OrderStatusAPI

    @HttpPost
    global static String updateOrderStatus(){

        Map<String,Object> data = (Map<String,Object>)JSON.deserializeUntyped( RestContext.request.requestBody.toString());

        String orderId = String.valueOf(data.get('orderId'));

        String status =  String.valueOf(data.get('status'));

        Order ord = [ SELECT Id, Status, Order_Status__c  FROM Order  WHERE Id = :orderId  LIMIT 10 ];

        ord.Warehouse_Shipment_Status__c = status;
        ord.Order_Status__c = 'Shipped Awaiting Invoice';

        update ord;

        return 'Order Updated Successfully';
    }
}


/*

@RestResource(urlMapping='/shipmentstatus')
global with sharing class ShipmentStatusAPI {

    @HttpPost
    global static String updateOrderStatus(){

        String body =
            RestContext.request.requestBody.toString();

        System.debug('REQUEST BODY = ' + body);

        Map<String,Object> data =
            (Map<String,Object>)JSON.deserializeUntyped(body);

        String orderId =
            String.valueOf(data.get('orderId'));

        String status =
            String.valueOf(data.get('status'));

        System.debug('Order Id = ' + orderId);
        System.debug('Status = ' + status);

        Order ord = [
            SELECT Id,
                   Status,
                   Order_Status__c
            FROM Order
            WHERE Id = :orderId
            LIMIT 1
        ];

        ord.Status = 'Activated';
        ord.Order_Status__c = 'Shipped Awaiting Invoice';

        update ord;

        System.debug('Order Updated');

        return 'Success';
    }
}
*/

/*

@RestResource(urlMapping='/shipmentstatus')
global with sharing class ShipmentStatusAPI { // OrderStatusAPI

    @HttpPost
    global static String updateOrderStatus(){

        Map<String,Object> data =
            (Map<String,Object>)JSON.deserializeUntyped(
                RestContext.request.requestBody.toString()
            );

        String orderId =
            String.valueOf(data.get('orderId'));

        String status =
            String.valueOf(data.get('status'));

        Order ord = [
            SELECT Id, Status
            FROM Order
            WHERE Id = :orderId
            LIMIT 1
        ];

        ord.Status = status;

        update ord;

        return 'Order Updated Successfully';
    }
}
*/
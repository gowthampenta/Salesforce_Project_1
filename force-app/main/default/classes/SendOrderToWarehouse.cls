public class SendOrderToWarehouse implements Queueable, Database.AllowsCallouts {

    private String orderId;
    private String orderNumber;

    public SendOrderToWarehouse(
        String orderId,
        String orderNumber){

        this.orderId = orderId;
        this.orderNumber = orderNumber;
    }

    public void execute(QueueableContext qc){
        
        System.debug('*** QUEUEABLE STARTED ***');

        HttpRequest req = new HttpRequest();

        req.setEndpoint(
            'callout:SalesforceNamedCred/services/apexrest/orders'
        );

        req.setMethod('POST');

        req.setHeader(
            'Content-Type',
            'application/json'
        );

        Map<String,Object> payload = new Map<String,Object>();

        payload.put('orderId',orderId);
        payload.put('orderNumber',orderNumber);

        req.setBody(
            JSON.serialize(payload)
        );

        Http http = new Http();

        HttpResponse res =  http.send(req);

        //System.debug(res.getBody());
        System.debug('Status Code = ' + res.getStatusCode());
        System.debug('Response = ' + res.getBody());
    }
}
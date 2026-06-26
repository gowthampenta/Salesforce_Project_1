public class AccountCallout { //HTTP CALLOUT

    public static void sendAccounts(List<Account> accList){

        Http http = new Http(); 
        HttpRequest req = new HttpRequest();

        req.setEndpoint('callout:SalesforceNamedCred/services/apexrest/AccountInt'); // we have to replace with target org endpoint
        req.setMethod('POST');
        req.setHeader('Content-Type','application/json');

        String body = JSON.serialize(accList);
        req.setBody(body);

        HttpResponse res = http.send(req);

        System.debug('Status Code: ' + res.getStatusCode());
        System.debug('Response: ' + res.getBody());
    }

} // HTTP CALLOUT         -     Check restAccount apex class in another salesforce org  - salesforce to salesforce integration
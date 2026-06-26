public class OracleCPQTest {

    public static void testConnection() {

        HttpRequest req = new HttpRequest();

        req.setEndpoint(
            'https://cpq-10194.bigmachines.com'
        );

        req.setMethod('GET');

        Http http = new Http();

        HttpResponse res = http.send(req);

        System.debug('Status: ' + res.getStatusCode());

        System.debug('Location: ' + res.getHeader('Location'));

        System.debug('Body: ' + res.getBody());
    }
}
public with sharing class Excel_Upload_Controller {

    @AuraEnabled
    public static void createAccounts(String jsonData) {

        List<Object> rows =
            (List<Object>)JSON.deserializeUntyped(jsonData);

        List<Account> accounts = new List<Account>();

        for(Object rowObj : rows){

            Map<String,Object> row =
                (Map<String,Object>)rowObj;

            Account acc = new Account();

            acc.Name =
                String.valueOf(row.get('Name'));

            acc.Phone =
                String.valueOf(row.get('Phone'));

            acc.Industry =
                String.valueOf(row.get('Industry'));

            accounts.add(acc);
        }

        if(!accounts.isEmpty()){
            insert accounts;
        }
    }
}
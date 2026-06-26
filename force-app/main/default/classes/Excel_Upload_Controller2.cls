public with sharing class Excel_Upload_Controller2 {

    @AuraEnabled
    public static String createAccounts(String jsonData) {

        Id batchId = Database.executeBatch(
            new AccountUploadBatch(jsonData),
            200
        );

        return String.valueOf(batchId);
    }
}
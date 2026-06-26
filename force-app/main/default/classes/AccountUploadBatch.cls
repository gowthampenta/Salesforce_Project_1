public class AccountUploadBatch implements Database.Batchable<Account>, Database.Stateful {

    private String jsonData;

    public Integer successCount = 0;
    public Integer duplicateCount = 0;
    public Integer failedCount = 0;

    public List<String> duplicateMessages = new List<String>();
    public List<String> failureMessages = new List<String>();

    public AccountUploadBatch(String jsonData) {
        this.jsonData = jsonData;
    }

    public Iterable<Account> start(
        Database.BatchableContext bc
    ) {

        List<Object> rows =
            (List<Object>)JSON.deserializeUntyped(jsonData);

        List<Account> accounts = new List<Account>();

        Set<String> excelNames = new Set<String>();

        Integer rowNumber = 2;

        for(Object obj : rows){

            Map<String,Object> row =
                (Map<String,Object>)obj;

            String accName =
                String.valueOf(row.get('Name'));

            if(String.isBlank(accName)){

                duplicateMessages.add(
                    'Row ' + rowNumber +
                    ' : Account Name is blank'
                );

                duplicateCount++;
                rowNumber++;
                continue;
            }

            if(excelNames.contains(accName)){

                duplicateMessages.add(
                    'Row ' + rowNumber +
                    ' : Duplicate in Excel - ' +
                    accName
                );

                duplicateCount++;
                rowNumber++;
                continue;
            }

            excelNames.add(accName);

            Account acc = new Account();
            acc.Name = accName;

            if(row.containsKey('Phone')){
                acc.Phone =
                    String.valueOf(row.get('Phone'));
            }

            if(row.containsKey('Website')){
                acc.Website =
                    String.valueOf(row.get('Website'));
            }

            accounts.add(acc);

            rowNumber++;
        }

        return accounts;
    }

    public void execute(
        Database.BatchableContext bc,
        List<Account> scope
    ) {

        Set<String> accountNames =
            new Set<String>();

        for(Account acc : scope){
            accountNames.add(acc.Name);
        }

        Map<String,Account> existingAccounts =
            new Map<String,Account>();

        for(Account acc :
            [
                SELECT Id, Name
                FROM Account
                WHERE Name IN :accountNames
            ]
        ){
            existingAccounts.put(
                acc.Name,
                acc
            );
        }

        List<Account> accountsToInsert =
            new List<Account>();

        for(Account acc : scope){

            if(existingAccounts.containsKey(
                acc.Name
            )){

                duplicateMessages.add(
                    'Already exists in Salesforce : '
                    + acc.Name
                );

                duplicateCount++;
                continue;
            }

            accountsToInsert.add(acc);
        }

        if(accountsToInsert.isEmpty()){
            return;
        }

        Database.SaveResult[] results =
            Database.insert(
                accountsToInsert,
                false
            );

        for(Integer i = 0;
            i < results.size();
            i++){

            if(results[i].isSuccess()){

                successCount++;

            }else{

                failedCount++;

                for(Database.Error err :
                    results[i].getErrors()){

                    failureMessages.add(
                        accountsToInsert[i].Name +
                        ' : ' +
                        err.getMessage()
                    );
                }
            }
        }
    }

    public void finish(Database.BatchableContext bc ) {

        String body =  'Account Upload Summary\n\n' +  
            
            'Successful Records : ' +  successCount +

            '\nDuplicate Records : ' + duplicateCount +

            '\nFailed Records : ' +   failedCount +

            '\n\nDuplicate Details\n' +

            (
                duplicateMessages.isEmpty()  ? 'None'   : String.join( duplicateMessages, '\n' )
            )

            +

            '\n\nFailure Details\n' +

            (
                failureMessages.isEmpty()
                ? 'None'
                : String.join(
                    failureMessages,
                    '\n'
                )
            );

        Messaging.SingleEmailMessage email =   new Messaging.SingleEmailMessage();

        email.setToAddresses(  new String[]{UserInfo.getUserEmail()
            }
        );

        email.setSubject(
            'Account Upload Batch Summary'
        );

        email.setPlainTextBody(body);

        Messaging.sendEmail(
            new Messaging.SingleEmailMessage[]{
                email
            }
        );
    }
}
public class AccountBatchDemo implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator(
            'SELECT Id, Description FROM Account LIMIT 5'
        );
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {

        for(Account acc : scope){

            acc.Description = 'Updated from Batch called by Future';
        }

        update scope;
    }

    public void finish(Database.BatchableContext bc){

        System.debug('Batch Finished');
    }
}
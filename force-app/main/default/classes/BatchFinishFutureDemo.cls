public class BatchFinishFutureDemo implements Database.Batchable<SObject> {

   
    public Database.QueryLocator start(Database.BatchableContext bc){

        return Database.getQueryLocator(
            'SELECT Id FROM Account LIMIT 5'
        );
    }

   
    public void execute(Database.BatchableContext bc, List<Account> scope){

        System.debug('Batch Execute Running');
    }

    
    public void finish(Database.BatchableContext bc){

        System.debug('Inside Finish Method');

        FutureFromBatchDemo.futureMethod();
    }
}
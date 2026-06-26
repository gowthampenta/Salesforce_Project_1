public class BatchEx2 implements Database.Batchable<SObject>{
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select id,AnnualRevenue from Account where AnnualRevenue > 100000');
    }
    
    public void execute(Database.BatchableContext bc,List<Account> accList){
        for(Account acc:accList){
            acc.Rating = 'Hot';
        }
        update accList;
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('Batch Job Completed Successfully');
    }
}

//BatchEx2 batch = new BatchEx2();
// Database.executeBatch(batch,200);   <-- anonymous window
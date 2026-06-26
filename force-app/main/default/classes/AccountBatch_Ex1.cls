global class AccountBatch_Ex1 implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select Id,Industry from Account');
    }
    
    global void execute(Database.BatchableContext bc, List<Account> accList){
        for(Account acc:accList){
            if(acc.Industry==null){
                acc.Industry = 'Technology';
            }
        }
        update accList;
    }
    
    global void finish(Database.BatchableContext bc){
        System.debug('Batch Completed');
    }
    //
    
}

// Schedule_Apex_1
// AccountBatch_Schedule_Ex1
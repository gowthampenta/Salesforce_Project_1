public class UpdateRevenue_Queueable implements Queueable{
    List<Account> accList;
    public UpdateRevenue_Queueable(List<Account> accList){
        this.accList = accList;
    }
    public void execute(QueueableContext context){
        for(Account acc:accList){
            acc.AnnualRevenue = (acc.AnnualRevenue == null ? 0 : acc.AnnualRevenue)+50000;
        }
        update accList;
    }
}

/*
public class UpdateRevenue_Queueable implements Queueable{
    List<Account> accList;
    public UpdateRevenue_Queueable(List<Account> accList){
        this.accList = accList;
    }
    public void execute(QueueableContext context){
        for(Account acc:accList){
            acc.AnnualRevenue = (acc.AnnualRevenue == null ? 0 : acc.AnnualRevenue)+50000;
        }
        update accList;
    }
}

*/

/*
List<Account> accs = [
    SELECT Id, AnnualRevenue 
    FROM Account 
    WHERE Name like '%Revenue%'
];

Id jobId = System.enqueueJob(new UpdateRevenue_Queueable(accs));
System.debug('JobId --> ' + jobId);
*/
global class BatchExample implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id, Name FROM Account');
    }

    global void execute(Database.BatchableContext bc, List<Account> accList) {
        for(Account acc : accList){
            acc.Name = acc.Name + ' - Batch Updated';
        }
        update accList;
    }

    global void finish(Database.BatchableContext bc) {
       // FutureDemo.updateAccount()
       // System.enqueueJob(new FutureDemo2())
       
        System.debug('Batch Completed');
    }
}




/*
 “Good morning everyone,
It is often assumed that success is reserved for the naturally gifted.
However, I firmly believe that consistency is far more powerful than talent.”

🔹 Body
Point 1: Talent without discipline is ineffective
“Talent may provide a strong beginning, but without discipline and persistence, it rarely leads to meaningful results.”

Point 2: Consistency creates excellence
“When we practice something regularly, even in small amounts, we gradually improve and build confidence.
Consistency transforms ordinary efforts into extraordinary outcomes.”

Point 3: Real-world perspective
“In reality, a moderately skilled person who is consistent will almost always outperform a highly talented individual who lacks commitment.”

🔹 Closing
“So, we should not be discouraged if we are not exceptionally talented.
Instead, we should focus on being consistent, dedicated, and resilient.
Because in the long run,
consistency will always surpass talent.
Thank you.”


 */
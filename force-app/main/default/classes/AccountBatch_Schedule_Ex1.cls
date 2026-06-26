global class AccountBatch_Schedule_Ex1 implements Schedulable {
    global void execute(SchedulableContext sc){
        Database.executeBatch(new AccountBatch_Ex1(), 20);
        
    }
}


/*

System.schedule(
    'Account Batch Nightly', 
    '0 30 23 * * ?',
    new AccountBatch_Schedule_Ex1()
);


*/ 

// comment code for anonymous window
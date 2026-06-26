public class FutureToBatchDemo {

    
     @future
    public static void callQueueable(){

        System.enqueueJob(new QueueablePractice());
    }
    
    
    /*
    
    @future
    public static void callBatch(){

        Database.executeBatch(new AccountBatchDemo(), 5);  //calling batch class in future method
    }
    
    // FutureToBatchDemo.callBatch(); - call this in anonymous winow
    
*/
    
}
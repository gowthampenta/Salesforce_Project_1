public class OpportunityFollowUpScheduler implements Schedulable {

    public void execute(SchedulableContext sc) {

        Database.executeBatch(
            new OpportunityFollowUpBatch(), 200
        );
    }
}
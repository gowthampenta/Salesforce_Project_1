public class OpportunityFollowUpBatch implements Database.Batchable<SObject> {

    public Database.QueryLocator start(Database.BatchableContext bc) {

        return Database.getQueryLocator(
            'SELECT Id, OwnerId ' + 'FROM Opportunity ' + 'WHERE IsClosed = FALSE ' + 'AND LastModifiedDate <= LAST_N_DAYS:30'
        );
    }

    public void execute(Database.BatchableContext bc, List<Opportunity> scope) {

        List<Task> tasksToInsert = new List<Task>();

        for(Opportunity opp : scope) {

            Task t = new Task(
                Subject = 'Follow up with customer',
                OwnerId = opp.OwnerId,
                WhatId = opp.Id,
                Status = 'Not Started',
                Priority = 'Normal'
            );

            tasksToInsert.add(t);
        }

        if(!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
        }
    }

    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Completed');
    }
}
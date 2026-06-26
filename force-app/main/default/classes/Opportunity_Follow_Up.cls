public class Opportunity_Follow_Up implements Schedulable {

    public static void execute(SchedulableContext sc) {

       List<Opportunity> oppList = [SELECT Id, Name, OwnerId FROM Opportunity WHERE IsClosed = FALSE 
                                    AND LastModifiedDate <= :System.now().addDays(-30)];

       List<Task> taskList = new List<Task>();

        for(Opportunity opp : oppList) {

            Task t = new Task();
            t.Subject = 'Follow up with customer';
            t.OwnerId = opp.OwnerId;
            t.WhatId = opp.Id;
            t.Status = 'Not Started';
            t.Priority = 'Normal';

            taskList.add(t);
        }

        if(!taskList.isEmpty()) {
            insert taskList;
        }
    }
}
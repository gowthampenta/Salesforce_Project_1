trigger Account_Trigger_Future2
on Account (after insert, after update) {

    if(TriggerHelper.isFirstRun){

        TriggerHelper.isFirstRun = false;

        List<Id> accIds = new List<Id>();

        for(Account acc : Trigger.new){

            accIds.add(acc.Id);
        }

        if(!accIds.isEmpty()){

          //  FutureDemo2.updateAccount(accIds);
        }
    }
}
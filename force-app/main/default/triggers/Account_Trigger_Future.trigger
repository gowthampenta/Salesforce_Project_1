trigger Account_Trigger_Future on Account(after insert){
    List<Id> accIds = new List<Id>();
    for(Account a : trigger.new){
        accIds.add(a.Id);
    }
  //  FutureDemo.updateAccounts(accIds);
}


/*
trigger AccountTrigger_Future on Account (after insert) {
    List<Id> accIds = new List<Id>();
    for(Account a : Trigger.new){
        accIds.add(a.Id);
    }

    FutureDemo.updateAccounts(accIds);
}
*/
//FutureDemo
trigger Before_Update_Trigger_1 on Account (before update) {
    for(Account acc:trigger.new){
        Account oldAcc = Trigger.oldMap.get(acc.Id);
        if(acc.Name != oldAcc.Name){
         //   acc.addError('Account Name Cannot be Change : Check Before Update Trigger 1 Code');
        }
        //system.debug('Account Industry ==>'+acc.industry);
    }
    System.debug('Before update Triggered');
}




//Before Update Check whether the Field data is Updated or not.










/*
 trigger PreventAccountRename on Account (before update) {
    for (Account acc : Trigger.new) {
        Account oldAcc = Trigger.oldMap.get(acc.Id);
        if (acc.Name != oldAcc.Name)
            acc.addError('Account name cannot be changed!');
    }
}


*/
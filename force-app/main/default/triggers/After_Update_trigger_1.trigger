trigger After_Update_trigger_1 on Account (after update) {
    for(Account acc:trigger.new){
        Account oldAcc = Trigger.oldmap.get(acc.id);
        Account newAcc = Trigger.newmap.get(acc.id);
        
        if(oldAcc != newAcc){
            system.debug('Record Updated');
        }else{
            system.debug('Not Updated');
        }
    }
    system.debug('After Update Triggered');
}
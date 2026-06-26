trigger Before_Insert_Trigger_1 on Account (before insert) {
    
    for(Account acc:trigger.new){
        if(acc.industry=='null'){
         //   acc.industry='Banking';
        }
    }
}






//Checks before Industry field whether it has value or not . If it doesn't have any data then it will get update to 'Banking'



/*

 for(Account acc: trigger.new){
        if(acc.Industry==null){
            acc.Industry='Banking';
        }
    }
    system.debug('Before Insert Triggered');

*/






/*
 
trigger SetDefaultIndustry on Account (before insert) {
    for (Account acc : Trigger.new) {
        if (acc.Industry == null) {
            acc.Industry = 'Technology';
        }
    }
}


*/
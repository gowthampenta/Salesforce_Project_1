trigger Set_default_value on Account (before insert) {

    for(Account acc:trigger.new){
        if(acc.Type==null){
            acc.Type='Prospect';
        }
    }
    
    
}
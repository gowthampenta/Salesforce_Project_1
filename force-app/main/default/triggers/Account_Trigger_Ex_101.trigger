trigger Account_Trigger_Ex_101 on Account (before insert,before update) {
    if(trigger.isinsert){
        if(trigger.isbefore){
          // Triggers_Ex_101.updatePhone(trigger.new,null);
        }
    }
    if(trigger.isupdate){
        if(trigger.isbefore){
          //  Triggers_Ex_101.updatePhone(trigger.new,trigger.oldmap);
        }
    }
}

// Triggers_Ex_101
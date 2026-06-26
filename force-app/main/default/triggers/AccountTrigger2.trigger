trigger AccountTrigger2 on Account (before insert,after insert,before update) {

    if(trigger.isinsert){
        if(trigger.isbefore){
             AccountTriggerHandler2.beforeInsert(trigger.new);
        }
        else if(trigger.isafter){
             AccountTriggerHandler2.afterInsert(trigger.new);
        }
    }else if(trigger.isupdate){
        if(trigger.isbefore){
            AccountTriggerHandler2.beforeUpdate(trigger.new,trigger.oldMap);
        }else if(trigger.isafter){
            AccountTriggerHandler2.afterUpdate(trigger.new,trigger.newmap,trigger.oldMap);
        }
    }else if(trigger.isdelete){
        if(trigger.isbefore){
            AccountTriggerHandler2.beforeDelete(trigger.old);
        }
        else if(trigger.isafter){
            AccountTriggerHandler2.afterDelete();
        }
    }else if(trigger.isundelete){
        if(trigger.isafter){
            AccountTriggerHandler2.afterUnDelete();
        }
    }
}
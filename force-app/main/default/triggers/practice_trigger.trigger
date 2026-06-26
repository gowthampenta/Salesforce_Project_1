trigger practice_trigger on Account (before insert,after insert,before update,after update) {
    System.debug('isinsert ==> '+Trigger.isinsert);
    System.debug('isupdate ==> '+Trigger.isupdate);
    System.debug('isdelete ==> '+Trigger.isdelete);
    System.debug('isundelete ==> '+Trigger.isundelete);
    System.debug('isbefore ==> '+Trigger.isbefore);
    System.debug('isafter ==> '+Trigger.isafter);
    System.debug('isexecuting ==> '+Trigger.isexecuting);
    
    System.debug('new data ==> '+Trigger.new);
    System.debug('new map data ==> '+Trigger.newmap);
    System.debug('old data ==> '+Trigger.old);
    System.debug('old map data ==> '+Trigger.oldmap);
    
    System.debug([select id,name,phone from Account where name like 'Trigger%']);
}
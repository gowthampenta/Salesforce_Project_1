trigger AccountTrigger101 on Account (before insert) {
    for(Account acc : Trigger.new){
        acc.Industry = 'IT';
    }
}
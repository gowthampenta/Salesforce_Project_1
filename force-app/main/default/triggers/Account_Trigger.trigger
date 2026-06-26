trigger Account_Trigger on Account (before insert) {
    for(Account acc:Trigger.new){
        acc.Rating = 'Hot';
    }
}
trigger practice_trigger_2 on Account (before insert) {
    // List<Account> accList = new List<Account>();
     for(Account acc:trigger.new){
         if(acc.rating=='Hot' && acc.NumberOfEmployees==null){
             acc.NumberOfEmployees = 100;
         }
    }
   
}
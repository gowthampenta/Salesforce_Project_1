trigger Delete_Record_trigger on Loan__c (before delete) {
        Set<Id> loanIds = new Set<Id>();
    
        List<Loan__c> loans = trigger.old;
        for(Loan__c L:loans){
             loanIds.add(L.id);
         }
        
        List<Customer__c> customersToDelete = [select id from Customer__c where Policy__c in:loanIds];
        delete customersToDelete;
       
} 

// delete customers in loan obj
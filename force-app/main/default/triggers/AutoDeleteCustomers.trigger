trigger AutoDeleteCustomers on Policy__c (after delete) {
  /*  List<Customer__c> customersToDelete = new List<Customer__c>();

    for (Policy__c policy : Trigger.old) {
        customersToDelete.addAll([
            SELECT Id FROM Customer__c WHERE Policy__c = :policy.Id
        ]);
    }

    if (!customersToDelete.isEmpty()) {
        delete customersToDelete;
    }
*/
}
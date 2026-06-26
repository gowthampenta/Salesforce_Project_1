public class AccountCalculator {
    @future
    public static void countContacts(List<Id> accIds){
        List<Account> accList = [select id,Count_No_Of_Contacts__c,(select id from contacts) from account where Id in : accIds];
        for(Account acc:accList){
            acc.Count_No_Of_Contacts__c = acc.Contacts.size();
        }
        
        if(!accList.isEmpty()){
            update accList;
        }
        
        system.debug(accList);
    }
}

/*

List<Id> accIds = new List<Id>();
List<Account> accList = new List<Account>();
for(Account acc:accList){
    accIds.add(acc.Id);
}
AccountCalculator.countContacts(accIds);

*/
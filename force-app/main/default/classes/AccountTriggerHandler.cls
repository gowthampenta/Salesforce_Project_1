public class AccountTriggerHandler {

    public void afterInsert(List<Account> newList) {
        List<Opportunity> oppList = new List<Opportunity>();

        for (Account acc : newList) {
            Opportunity opp = new Opportunity(
                Name = acc.Name + ' Opportunity',
                StageName = 'Prospecting',
             // CloseDate = acc.Account_Expiration_date__c,
                Phone__c = acc.Phone,
                AccountId = acc.Id
            );
            oppList.add(opp);
        }

        insert oppList;
    }
}
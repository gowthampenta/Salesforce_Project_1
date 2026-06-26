public class OpportunityHandler {
    public static void updateClosedWonCount(Set<Id> accIds) {
        if (accIds.isEmpty()) return;

        // 1) Count Closed Won Opps per Account
        Map<Id, Integer> countMap = new Map<Id, Integer>();

        for (AggregateResult ar : [
            SELECT AccountId acc, COUNT(Id) cnt
            FROM Opportunity
            WHERE AccountId IN :accIds
            AND StageName = 'Closed Won'
            GROUP BY AccountId
        ]) {
            countMap.put((Id)ar.get('acc'), (Integer)ar.get('cnt'));
        }

        // 2) Update Accounts with new count
        List<Account> accList = new List<Account>();
        for (Id accId : accIds) {
            accList.add(new Account(
                Id = accId,
                Closed_Won_Count__c = countMap.containsKey(accId) ? countMap.get(accId) : 0
            ));
        }

        update accList;
    }

}


// Get count of opportunities which are having stage=Closed won and populate on parent account
// 1. Whenever opportunity amount is changed, that date needs to be captured in a field
// 2. All opportunities for particular dates (which are modified) need to send email to admin in Excel, opportunity name, id, modified by
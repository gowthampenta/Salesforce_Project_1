public class AccountTriggerTest {

    public static void updateOpportunityStages(Set<Id> accountIds){

        List<Opportunity> oppsToUpdate = new List<Opportunity>();

        for(Opportunity opp : [SELECT Id, StageName, CreatedDate FROM Opportunity WHERE AccountId IN :accountIds]){
            
            if(opp.CreatedDate.date() <= Date.today().addDays(-30) && opp.StageName != 'Finalization'){
                opp.StageName = 'Closed';
                oppsToUpdate.add(opp);
            }
            
        }

        if(!oppsToUpdate.isEmpty()){
            update oppsToUpdate;
        }
    }
}
public class FutureDemo2 {

    @future
    public static void updateAccount(List<Id> accIds){

        List<Account> accList = [
            SELECT Id, Name, Plan_Type__c, Description
            FROM Account
            WHERE Id IN :accIds
        ];

        for(Account acc : accList){

            if(acc.Plan_Type__c == 'ESOP'){

                acc.Description =
                    'Plan Type Changed to ESOP from future method';

            }else{

                acc.Description =
                    'Plan Type is Not Changed';
            }
        }

    //    update accList;
    }
}

//Account_Trigger_Future2
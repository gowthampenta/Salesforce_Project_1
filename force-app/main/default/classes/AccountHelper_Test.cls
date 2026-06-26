@isTest
public class AccountHelper_Test {
    
    @isTest
    public static void testUpdateRevenue(){
        
        // 1. Test data creation
        Account acc = new Account(Name='Test',Phone='1212111111');
        insert acc;

        // 2. Query data for method
        List<Account> accList = [SELECT Id, AnnualRevenue FROM Account];

        // 3. Call the method
        AccountHelper.updateRevenue(accList);

        // 4. Assert to check correctness
        Account updatedAcc = [SELECT AnnualRevenue FROM Account WHERE Id = :acc.Id];
        System.assertEquals(50000, updatedAcc.AnnualRevenue);
    }
}
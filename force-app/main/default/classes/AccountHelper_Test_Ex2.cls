@isTest
public class AccountHelper_Test_Ex2 {
    @isTest
    public static void updateAccountIndustry_Test(){
        Account acc = new Account(Name='Test_1',Phone='1213151617');
        insert acc;
        List<Account> accList = [Select Id,Industry from Account];
        AccountHelper_Ex2.updateIndustry(accList);
        Account UpdateAcc = [Select Id,Industry from Account where Id=:acc.Id];
        System.AssertEquals('Energy',UpdateAcc.Industry);
    }
}
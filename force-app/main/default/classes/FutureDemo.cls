public class FutureDemo{
    @future
    public static void updateAccounts(List<Id> accIds){
        List<Account> accList = [Select Id,Name From Account Where Id IN : accIds];
        for(Account acc : accList){
            acc.Type = 'Prospect';
        }
        update accList;
    }
}

/*

public class FutureDemo {
    @future
    public static void updateAccounts(List<Id> accIds) {
        List<Account> accList = [SELECT Id, Name FROM Account WHERE Id IN :accIds];
        for (Account acc : accList) {
            acc.Type = 'Prospect';  // type updated
        }
        update accList;
        System.debug('Future Demo called --> Type Updated');
        System.debug('Future Demo --> '+accList);
    }
}

 */

//AccountTrigger_Future-
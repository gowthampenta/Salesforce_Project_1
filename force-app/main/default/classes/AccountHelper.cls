public class AccountHelper {
    public static void updateRevenue(List<Account> accList){
        for(Account acc : accList){
            acc.AnnualRevenue = 50000;
        }
        update accList;
    }
}

// AccountHelper_Test
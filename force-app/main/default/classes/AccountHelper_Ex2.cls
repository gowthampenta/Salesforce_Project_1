public class AccountHelper_Ex2 {
    public static void updateIndustry(List<Account> accList){
        for(Account acc: accList){
            acc.Industry = 'Energy';
        }
        update accList;
    }
}
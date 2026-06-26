public class SOQL_EXP_2 {
    public double amount {set;get;}
    public List<account> accList{set;get;}
    
    public void searchAccounts(){
        accList = [select id,Name,AnnualRevenue from account where AnnualRevenue>=:amount];
    }
}
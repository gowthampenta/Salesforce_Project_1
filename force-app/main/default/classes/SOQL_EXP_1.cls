public class SOQL_EXP_1 {
    public List<account> accList{set;get;}
    public SOQL_EXP_1(){
        accList = [select id,Name,AnnualRevenue,industry from account];
    }
}
public class SOQL_Parent_to_Child {
    public List<Account> accList{set;get;}
    public SOQL_Parent_to_Child(){
        accList = [select id,name,rating,(select id,lastname from contacts) from account];
    }
}
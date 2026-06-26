public class SOQL_Child_to_Parent {
    public List<contact> contacts{set;get;}
    public SOQL_Child_to_Parent(){
        contacts = [select id,Lastname,Account.id,Account.name from contact];
    }
    
}
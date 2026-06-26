public class List_Ex3{
    public List<Account> accList{set;get;}
    public void showAccounts(){
         accList = new List<Account>();
         Account a1 = new Account(name='acc1',industry='Banking');
         Account a2 = new Account(name='acc2',industry='Banking');
        
         accList.add(a1);
         accList.add(a2);
    }
}
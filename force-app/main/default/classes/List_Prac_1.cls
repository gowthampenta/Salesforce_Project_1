public class List_Prac_1 {
    public List<Account> accList{set;get;}
  //  public Account[] accArray{set;get;}
    
    public void showAccounts(){
         Account a1 = new Account(name='Acc1',industry='Banking');
         Account a2 = new Account(name='Acc2',industry='Energy');
         
         
    
        accList = new List<Account>();
        accList.add(a1);
        accList.add(a2);
        
     //   Account acc1 = new Account(name='Hi');
        
     //   accArray.add(acc1);
        
    }
    
}
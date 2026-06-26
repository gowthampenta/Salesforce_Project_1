public class Array_Prac_1 {
    public Account[] accarray{set;get;}
    
    Account a1 = new Account(name='acc1',rating='Hot',industry='Banking');
    Account a2 = new Account(name='acc2',rating='Cold',industry='Energy');
    Account a3 = new Account(name='acc3',rating='Warm',industry='Healthcare');
    
    public Array_Prac_1(){
        accarray = new Account[]{a1,a2,a3};
    }
    
}
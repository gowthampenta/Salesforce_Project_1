public class Array_Ex2 {
    public Account[] accArray{set;get;}
    
    Account a1 = new Account(name='Gowtham',rating='Hot',Industry='Technology');
    Account a2 = new Account(name='Shaik',rating='Cold',Industry='Banking');
    Account a3 = new Account(name='Ravi',rating='Warm',Industry='Food & Beverages');
    
    public Policy__c[] policyArr{set;get;}
    
    Policy__c p1 = new Policy__c(Name='Health Insurance',Policy_Amount__c=50000,Policy_Tenure__c=5);
    Policy__c p2 = new Policy__c(Name='Car Insurance',Policy_Amount__c=20000,Policy_Tenure__c=6);
    Policy__c p3 = new Policy__c(Name='Bike Insurance',Policy_Amount__c=10000,Policy_Tenure__c=3);
    
    public Array_Ex2(){
        accArray = new Account[]{a1,a2,a3};
        policyArr = new Policy__c[]{p1,p2,p3};
            }
    
    
}
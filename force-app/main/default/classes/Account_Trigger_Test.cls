@isTest
public class Account_Trigger_Test {
    @isTest
    public static void testTrigger(){
        Account acc = new Account(name='Account Trigger Rating Test apex 1',Phone='3333333333');
        insert acc;
        Account updateRating = [Select id,Rating from Account where id=:acc.id];
        System.assertEquals('Hot',updateRating.Rating);
        System.debug('Rating --> '+updateRating.Rating);
    }
}
public class AccountTrigger{

public static void Auto_Fill_ContactData(List<Account> accList){
       List<Contact> conList = new List<Contact>();
       for(Account acc:accList){
               conList.add(new Contact(
               LastName = acc.name,Phone=acc.Phone,Email=acc.Email_Address__c,AccountId=acc.Id
          ));
      


    }            
        //   insert accList;

    }



}
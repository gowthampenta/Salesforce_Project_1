public class AccountTriggerHandler2 {
    
    public static void beforeInsert(List<Account> accList){
        for(Account acc:accList){
            system.debug('Account Name : '+acc.name);
        }
    }
    
    public static void afterInsert(List<Account> accList){
        List<Case> caseList = new List<Case>();
        for(Account acc:accList){
            case newCase = new case(
               Status = 'New',
               Origin = 'Phone',
               SuppliedEmail = acc.Email_Address__c,
               SuppliedPhone = acc.Phone,
               AccountId = acc.Id,
               Subject = acc.Name+' Subject'
            );
            caseList.add(newCase);
        }
        insert caseList;
    }
    
    public static void beforeUpdate(List<Account> accList,Map<Id,Account> oldMap){
        for(Account acc:accList){
            if(oldMap != null && acc.phone != oldMap.get(acc.Id).phone){
                acc.Description = 'Phone Number is Updated in Account';
            }

        }
    }
    
    public static void afterUpdate(List<Account> accList, Map<Id, Account> newMap, Map<Id, Account> oldMap) {
        Set<Id> keys = oldMap.keyset();
        Set<Id> accountIdKeysToCheckPhoneUpdate = new Set<Id>();
        for(Id k:keys){
            Account oldAccId = oldMap.get(k);
            Account newAccId = newMap.get(k);
            
            
            if(oldAccId.Phone != newAccId.Phone){
                accountIdKeysToCheckPhoneUpdate.add(k);
            }
        }
        
        List<Contact> conList = [Select id,lastname,email,leadsource,phone,AccountId from contact where AccountId In:accountIdKeysToCheckPhoneUpdate];
        for(Contact c:conList){
            c.Phone = newMap.get(c.AccountId).Phone;
        }
        update conList;
    }
    
    public static void beforeDelete(List<Account> oldAcc){
        if (Trigger.isBefore && Trigger.isDelete) {
        for (Account acc : oldAcc) {
            if (acc.Type == 'Prospect') {
                acc.addError('Prospect Accounts cannot be deleted.');
            }
        }
    }
    }
    
    public static void afterDelete(){
         //Delete related Contacts after Account deletion
        if (Trigger.isAfter && Trigger.isDelete) {
              List<Contact> consToDelete = [SELECT Id FROM Contact WHERE AccountId IN :Trigger.old];
              delete consToDelete;
        }

    }
    
    public static void afterUnDelete(){
         // Restore related Contacts after Account undelete
         if (Trigger.isAfter && Trigger.isUndelete) {
                  System.debug('Restored Accounts: ' + Trigger.new);
                 // Example: logic to recreate related records
         }else{
             System.debug('Not Restored Accounts: ' + Trigger.new);
         }
    }

    
    /* public static void afterUpdate(List<Account> accList,Map<Id,Account> oldMap){
        
        set<id> accountEligibleIds = new set<id>();
        
        for(Account acc:accList){
            if(acc.rating=='Hot'){
                accountEligibleIds.add(acc.Id);
            }
        }
        
        Set<id> accountIds = oldMap.keyset();
        List<Contact> conList = [Select id,lastname,email,leadsource from contact where accountId In:accountEligibleIds];
        for(Contact con:conList){
            con.LeadSource = 'Web';
        }
        system.debug([Select id,lastname,email,leadsource from contact where accountId In:accountEligibleIds]);
        update conList;
    }

*/
    
    
    
}
public class AccountHandler1 {
	@AuraEnabled(cacheable=true)
	public static List<Account> getAllAccounts(){
		List<Account> accList = [Select id,name,rating from Account];
		return accList;
	}
}
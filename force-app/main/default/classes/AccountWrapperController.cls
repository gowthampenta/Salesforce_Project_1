public class AccountWrapperController {

    public List<AccountWrapper> wrapList { get; set; }
    public List<Account> selectedAccounts { get; set; }   // <-- FIXED (class-level)

    public AccountWrapperController() {
        wrapList = new List<AccountWrapper>();
        selectedAccounts = new List<Account>(); // <-- initialize it

        for (Account a : [SELECT Id, Name, Industry FROM Account LIMIT 5]) {
            wrapList.add(new AccountWrapper(a));
        }
    }

    // Method to get selected records
    public void processSelected() {

        selectedAccounts.clear();  // <-- clear old selections

        for (AccountWrapper wrap : wrapList) {
            if (wrap.isSelected == true) {
                selectedAccounts.add(wrap.acc);
            }
        }

        System.debug('Selected Accounts: ' + selectedAccounts);
    }
}
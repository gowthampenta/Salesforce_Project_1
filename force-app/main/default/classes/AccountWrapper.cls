public class AccountWrapper {

    public Account acc { get; set; }          // Store Account record
    public Boolean isSelected { get; set; }   // Extra field (Checkbox)

    // Constructor
    public AccountWrapper(Account a) {
        acc = a;
        isSelected = false;
    }
}
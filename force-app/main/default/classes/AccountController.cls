public class AccountController {
    public Boolean showPhone {get; set;}
    public Account acc {get; set;}

    public AccountController() {
        acc = new Account();
        showPhone = false; // hidden by default
    }
}


// AccountFormPage
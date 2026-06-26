public class sendEmailExample {
    public static void sendEmail(){
         Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
         mail.setToAddresses(new String[]{'gowthampenta3@gmail.com'});
         mail.setSubject('Testing Mail 1');
         mail.setPlainTextBody('Thanks for Contacting us...!!');
         Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }
}


//outbound email

//madhavnarendra6@gmail.com
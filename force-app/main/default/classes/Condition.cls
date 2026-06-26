public class Condition {
    public void check(){
        Integer ticket_price = 100;
        Integer balance = 1000;
        if(balance>=ticket_price){
            System.debug('Enough to buy ticket');
        }else{
            System.debug('Need Some balance to buy ticket');
        }
    }
}
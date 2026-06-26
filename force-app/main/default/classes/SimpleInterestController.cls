public class SimpleInterestController {
    public Decimal principal { get; set; }
    public Decimal rate { get; set; }
    public Decimal timee { get; set; }
    public Decimal interest { get; set; }

    public SimpleInterestController() {
        principal = 0;
        rate = 0;
        timee = 0;
        interest = 0;
    }

    public void calculateInterest() {
        if (principal > 0 && rate > 0 && timee > 0) {
            interest = (principal * rate * timee) / 100;
        } else {
            interest = 0;
        }
    }
}
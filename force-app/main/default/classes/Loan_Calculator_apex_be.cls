public class Loan_Calculator_apex_be {
    public Decimal annInt_val { get; set; }
    public Decimal year_val { get; set; }
    public Decimal amount_val { get; set; }
    
    public Decimal monthly_pay_val { get; set; }
    public Decimal tot_pay_val { get; set; }

    public void compute() {
        // Convert annual interest rate to monthly rate
        Double monthlyRate = (Double.valueOf(annInt_val) / 100) / 12;
        // Total number of months
        Integer totalMonths = Integer.valueOf(year_val * 12);
        
        if (monthlyRate > 0) {
            // Apply loan formula using Double
            Double numerator = monthlyRate * Math.pow((1 + monthlyRate), totalMonths);
            Double denominator = Math.pow((1 + monthlyRate), totalMonths) - 1;
            Double monthlyPayment = Double.valueOf(amount_val) * (numerator / denominator);
            
            // Convert Double → Decimal → setScale
            monthly_pay_val = Decimal.valueOf(monthlyPayment).setScale(2);
        } else {
            // If 0% interest
            monthly_pay_val = (amount_val / totalMonths).setScale(2);
        }
        
        // Total payment
        tot_pay_val = (monthly_pay_val * totalMonths).setScale(2);
    }
}
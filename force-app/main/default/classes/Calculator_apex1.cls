public class Calculator_apex1 {
    public Decimal annInt_val { get; set; }
    public Decimal year_val { get; set; }
    public Decimal amount_val { get; set; }
    public Decimal monthly_pay_val { get; set; }
    public Decimal tot_pay_val { get; set; }
    public String monthly_pay_res  { get; set; }
    public String total_pay_res { get; set; }
     public String warning { get; set; }

    public void compute() {
        // Check if input fields are valid
        if (annInt_val == null || year_val == null || amount_val == null || year_val == 0) {
            
            monthly_pay_res  = '';
            total_pay_res = '';
            warning = '⚠️ Please enter valid input values.';
            annInt_val = null;
            year_val = null;
            amount_val = null;
            return;
        }else{
            warning='';
        }

        Double r = (Double.valueOf(annInt_val) / 100) / 12; // monthly interest
        Integer n = Integer.valueOf(year_val * 12);         // total months
        Double p = Double.valueOf(amount_val);              // principal

        Double m; // monthly payment

        if (r > 0) {
            m = p * (r * Math.pow(1 + r, n)) / (Math.pow(1 + r, n) - 1);
        } else {
            m = p / n;
        }

        monthly_pay_val = (Decimal.valueOf(m).setScale(2));
        tot_pay_val = (monthly_pay_val * n).setScale(2);
        
        monthly_pay_res = 'Monthly Payment : ' + monthly_pay_val;
        total_pay_res = 'Total Payment : ' + tot_pay_val;
    }
}
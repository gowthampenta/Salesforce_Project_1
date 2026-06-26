public class pageReference_Ex {
    public pageReference simple_interest(){
        pageReference p = new pageReference('/apex/Simple_Interest_Calculator');
        return p;
    }
    public pageReference loan_Calculator(){
        pageReference p = new pageReference('/apex/Calculator_UI');
        return p;
    }
}
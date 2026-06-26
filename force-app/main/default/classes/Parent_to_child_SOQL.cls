public class Parent_to_child_SOQL {
    
    public void showAcc(){
        List<account> accList = [Select name,industry from Account];
        system.debug(accList);
    }
    
}
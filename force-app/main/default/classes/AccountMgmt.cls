@RestResource(urlMapping='/accountmgmt/')
global class AccountMgmt {
    @httpGet
    global static List<Account> getTopAccounts(){
         List<Account> accList = [Select id,industry,rating,annualrevenue from account where annualrevenue != null order by annualrevenue desc limit 10];
         return accList;
    }
}
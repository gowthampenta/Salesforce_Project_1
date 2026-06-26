public class dynamicSOQL {
    public static void soql_data() {
      //  String industry = 'Banking';
        String industry = 'Energy';
      //  String q = 'SELECT Id, Name, Industry FROM Account WHERE Industry = \'' + industry + '\'';
          String q = 'Select Id, Name, Industry From Account where Industry = \'' + industry + '\'';
      //  List<Account> accList = Database.query(q);
         List<Account> accList = Database.query(q);

        System.debug('*** Query String = ' + q);
        System.debug('*** Total Records = ' + accList.size());
        System.debug('*** Records = ' + accList);
    }
}


// dynamicSOQL.soql_data();
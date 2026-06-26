public with sharing class PaginationController2 {

    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getAccounts(String pageType, Id lastId, Integer limitSize) {

        List<String> fields;

        if(pageType == 'admin'){
            fields = new List<String>{'Id','Name','Industry','Phone','Rating'};
        } else {
            fields = new List<String>{'Id','Name','Industry'};
        }

        String fieldStr = String.join(fields, ',');

        String query;

        if(lastId == null){
            query = 'SELECT ' + fieldStr + ' FROM Account ORDER BY Id LIMIT :limitSize';
        } else {
            query = 'SELECT ' + fieldStr + ' FROM Account WHERE Id > :lastId ORDER BY Id LIMIT :limitSize';
        }

        List<SObject> records = Database.query(query);


        List<Map<String, String>> columns = new List<Map<String, String>>();

        for(String f : fields){
            if(f != 'Id'){
                columns.add(new Map<String, String>{
                    'label' => f,
                    'fieldName' => f
                });
            }
        }

        return new Map<String, Object>{
            'records' => records,
            'columns' => columns
        };
    }
}
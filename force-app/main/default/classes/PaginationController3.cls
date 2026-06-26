public with sharing class PaginationController3 {

    public static List<String> getFieldsByProfile() {

        String profileName = [SELECT Name FROM Profile WHERE Id = :UserInfo.getProfileId()].Name;

        if(profileName == 'System Administrator'){
            return new List<String>{'Id','Name','Industry','Phone','Rating'};
        } else{
            return new List<String>{'Id','Name','Industry','AnnualRevenue'};
        }
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getAccounts(Id lastId, Integer limitSize) {

        List<String> fields = getFieldsByProfile();
        String fieldStr = String.join(fields, ',');

        String query;

        if(lastId == null){
            query = 'SELECT ' + fieldStr + ' FROM Account ORDER BY Id LIMIT :limitSize';
        } else {
            query = 'SELECT ' + fieldStr + ' FROM Account WHERE Id > :lastId ORDER BY Id LIMIT :limitSize';
        }

        List<SObject> records = Database.query(query);

        return prepareResponse(records, fields);
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getPreviousAccounts(Id firstId, Integer limitSize) {

        List<String> fields = getFieldsByProfile();
        String fieldStr = String.join(fields, ',');

        String query = 'SELECT ' + fieldStr + ' FROM Account WHERE Id < :firstId ORDER BY Id DESC LIMIT :limitSize';

        List<SObject> records = Database.query(query);

        return prepareResponse(records, fields);
    }

    public static Map<String, Object> prepareResponse(List<SObject> records, List<String> fields){

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
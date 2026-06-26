public with sharing class DynamicJsonProcessor {

    public static void processJson(String jsonBody) {

        Map<String,Object> rootMap = (Map<String,Object>)JSON.deserializeUntyped(jsonBody);

        List<Account> accountsToInsert = new List<Account>();

        for(String category : rootMap.keySet()) {

            Map<String,Object> categoryMap = (Map<String,Object>)rootMap.get(category); // from here we get category data like region and country

            // Process Region Records
            if(categoryMap.containsKey('region')) {

                List<Object> regionList =  (List<Object>)categoryMap.get('region');

                for(Object obj : regionList) {

                    Map<String,Object> regionMap = (Map<String,Object>)obj;

                    Integer regionId = Integer.valueOf(regionMap.get('id'));

                    String regionName = String.valueOf(regionMap.get('name'));

                    Account acc = new Account();
                    acc.Name = regionName;

                    // Example custom fields
                     acc.regionId__c = String.valueOf(regionId);
                    // acc.Category__c = category;

                    accountsToInsert.add(acc);
                }
            }

            // Process Country Object
            if(categoryMap.containsKey('country')) {

                Map<String,Object> countryMap = (Map<String,Object>)categoryMap.get('country');

                Integer countryId = Integer.valueOf(countryMap.get('id'));

                String company = String.valueOf(countryMap.get('company'));
           
                System.debug('Country Id: ' + countryId);
                System.debug('Company: ' + company);
            }
        }

        if(!accountsToInsert.isEmpty()) {
            insert accountsToInsert;
        }
    }
}
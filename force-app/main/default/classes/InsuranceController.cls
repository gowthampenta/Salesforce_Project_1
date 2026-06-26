public with sharing class InsuranceController {

    @AuraEnabled(cacheable=true)
    public static List<String> getInsuranceValues() {

        Id profileId = UserInfo.getProfileId();
        String profileName = [
            SELECT Name 
            FROM Profile 
            WHERE Id = :profileId
        ].Name;

        List<Insurance_Mapping__mdt> records = [
            SELECT Allowed_Values_c__c
            FROM Insurance_Mapping__mdt 
            WHERE Profile_Name__c = :profileName 
            LIMIT 1
        ];

        if(!records.isEmpty() && records[0].Allowed_Values_c__c != null){
            return records[0].Allowed_Values_c__c.split(',');
        }

        return new List<String>();
    }
}
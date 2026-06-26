public with sharing class OpportunityOverrideController {

    // 🔹 Fetch Record Types
    @AuraEnabled(cacheable=true)
    public static List<RecordTypeInfoWrapper> getOpportunityRecordTypes() {
        List<RecordTypeInfoWrapper> result = new List<RecordTypeInfoWrapper>();

        Map<Id, Schema.RecordTypeInfo> rtMap =
            Schema.SObjectType.Opportunity.getRecordTypeInfosById();

        for (Schema.RecordTypeInfo rt : rtMap.values()) {
            if (rt.isAvailable()) {
                result.add(new RecordTypeInfoWrapper(
                    rt.getRecordTypeId(),
                    rt.getName()
                ));
            }
        }
        return result;
    }

    // 🔹 Wrapper Class
    public class RecordTypeInfoWrapper {
        @AuraEnabled public Id recordTypeId;
        @AuraEnabled public String name;

        public RecordTypeInfoWrapper(Id id, String name) {
            this.recordTypeId = id;
            this.name = name;
        }
    }

    // 🔹 Fetch Account details (Auto-fill)
    @AuraEnabled
    public static Account getAccountDetails(Id accId) {
        return [
            SELECT Id, Name, Industry
            FROM Account
            WHERE Id = :accId
            LIMIT 1
        ];
    }

    // 🔥 NEW: Fetch Fields from Field Set (Dynamic)
    @AuraEnabled(cacheable=true)
    public static List<String> getFieldsByRecordType(String recordTypeId) {

        // TEMP: using single Field Set for testing
        String fieldSetName = 'FS_401k_Admin';

        List<String> fields = new List<String>();

        Schema.FieldSet fs =
            Schema.SObjectType.Opportunity.FieldSets.getMap().get(fieldSetName);

        if (fs != null) {
            for (Schema.FieldSetMember f : fs.getFields()) {
                fields.add(f.getFieldPath());
            }
        }

        return fields;
    }
}
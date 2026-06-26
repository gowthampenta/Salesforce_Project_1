public class DeletedRecordController {

    public static void saveDeletedRecords(
        List<SObject> oldRecords,
        String objectApiName
    ){

        List<Deleted_Record__c> deletedList =
            new List<Deleted_Record__c>();

        for(SObject sob : oldRecords){

            Deleted_Record__c dr =
                new Deleted_Record__c();
            

            String recName = '';

            String sObjectName =
                sob.getSObjectType().getDescribe().getName();

            if(sObjectName == 'Contact'){

                String firstName = '';
                String lastName = '';

                if(sob.get('FirstName') != null){
                    firstName =
                        String.valueOf(sob.get('FirstName'));
                }

                if(sob.get('LastName') != null){
                    lastName =
                        String.valueOf(sob.get('LastName'));
                }

                recName = firstName + ' ' + lastName;
            }
            else{

                if(sob.get('Name') != null){
                    recName =
                        String.valueOf(sob.get('Name'));
                }
            }

            dr.Name = recName;

            dr.Record_Id__c =
                String.valueOf(sob.get('Id'));

            dr.Object_API_Name__c =
                objectApiName;

            dr.Deleted_By__c =
                UserInfo.getUserId();

            dr.Deleted_Date_Time__c =
                System.now();

            deletedList.add(dr);
        }

        if(!deletedList.isEmpty()){
            insert deletedList;
        }
    }
}
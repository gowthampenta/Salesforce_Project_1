trigger triggerHandler on Account(before insert){
     
     if(trigger.isInsert && trigger.isBefore){

        //  AccountTrigger.Auto_Fill_ContactData(trigger.new);


   }


}
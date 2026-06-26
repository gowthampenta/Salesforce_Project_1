trigger After_Insert_Trigger_1 on Account (after insert) {
    List<Contact> conList = new List<Contact>();
    for (Account acc : Trigger.new) {
        conList.add(new Contact(
            LastName = acc.Name + ' Contact',
            AccountId = acc.Id,
            Phone=acc.phone,
            Email=acc.Email_Address__c
        ));
    }
   // insert conList;
    system.debug('After Insert Triggered');
}


// After Inserting Account field data it will create new Contact with above mentioned fields



/*
 trigger CreateContactAfterAccount on Account (after insert) {
    List<Contact> conList = new List<Contact>();

    for (Account acc : Trigger.new) {
        Contact con = new Contact(
            LastName = acc.Name + ' Contact',
            AccountId = acc.Id
        );
        conList.add(con);
    }

    insert conList;
}


*/










/*
trigger CreateContactOnAccount on Account (after insert) {
    List<Contact> conList = new List<Contact>();

    for (Account acc : Trigger.new) {
        conList.add(new Contact(
            LastName = acc.Name + ' Contact',
            AccountId = acc.Id
        ));
    }

    insert conList;
}
*/
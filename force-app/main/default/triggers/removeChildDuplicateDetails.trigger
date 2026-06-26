trigger removeChildDuplicateDetails on Contact(before insert, before update) {
/*
    Set<String> keys = new Set<String>();

    for(Contact c : Trigger.new){
        if(c.AccountId != null && c.Email != null){
            keys.add(c.AccountId + '-' + c.Email);
        }
    }

    Map<String, Contact> existingMap = new Map<String, Contact>();

    for(Contact con : [
        SELECT Id, AccountId, Email
        FROM Contact
        WHERE AccountId IN :Trigger.newMap.keySet()
    ]){
        existingMap.put(con.AccountId + '-' + con.Email, con);
    }

    for(Contact c : Trigger.new){
        String key = c.AccountId + '-' + c.Email;

        if(existingMap.containsKey(key)){
           // c.Email.addError('Duplicate Contact Email under same Account');
        }
    }
*/
}
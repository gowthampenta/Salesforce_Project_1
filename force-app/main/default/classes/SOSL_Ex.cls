public class SOSL_Ex {
    public List<List<sObject>> result { get; set; }
    public List<Account> accList { get; set; }
    public List<Contact> conList { get; set; }
    public List<Opportunity> oppList { get; set; }

    public SOSL_Ex() {
        result = [FIND 'SBI' IN ALL FIELDS RETURNING 
                    Account(Id, Name), 
                    Contact(Id, LastName, Email), 
                    Opportunity(Id, Name, StageName)];
        accList = (List<Account>)result[0];
        conList = (List<Contact>)result[1];
        oppList = (List<Opportunity>)result[2];
    }
}

//SOSL_Ex.vfp










/* public class SOSL_Ex {
    public List<List<sObject>> result{set;get;}
    public List<Account> accList{set;get;}
    public List<Contact> conList{set;get;}
    public List<Opportunity> oppList{set;get;}
    
    public SOSL_EX(){
        result = [find 'test' in all fields returning account(Id,Name),contact(Id,LastName,Email),opportunity(Id,Name,StageName)];
        accList = (List<Account>)result[0];
        conList = (List<Contact>)result[1];
        oppList = (List<Opportunity>)result[2];
    }
}

*/
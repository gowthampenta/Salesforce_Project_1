global class InboundEmailHandlerEx1 implements Messaging.InboundEmailHandler{
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope){
        Case c = new Case();
        c.Subject = email.subject;
        c.Description = email.plainTextBody;
        c.Status = 'New';
        insert c;
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        result.success = true;
        return result;
    }
   
}
/*
global class InboundEmailHandlerEx1 implements Messaging.InboundEmailHandler{
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope){
        
        Case c = new Case();
        c.Subject = email.subject;
        c.Description = email.plainTextBody;
        c.Status = 'New';
        insert c;
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        result.success = true;
        return result;
    }
}
*/
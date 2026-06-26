public class QueueablePractice implements Queueable {

    public void execute(QueueableContext qc){

        List<Contact> conList = [
            SELECT Id, Description
            FROM Contact
            LIMIT 5
        ];

        for(Contact con : conList){

            con.Description = 'Updated By Queueable';
        }

        update conList;
    }
}
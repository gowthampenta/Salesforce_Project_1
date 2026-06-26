// Account_Trigger_Ex_101
public class Triggers_Ex_101 {
    public static void updatePhone(List<Account> accList, Map<Id, Account> oldmapId) {
        for (Account acc : accList) {
           // Account oldAcc = oldmapId.get(acc.Id);
            if ((oldmapId == null && acc.Industry != null && acc.Industry == 'Media') ||
                (oldmapId != null && (acc.Industry != oldmapId.get(acc.id).Industry) && acc.Industry == 'Media')) {
                acc.Rating = 'Hot';
            }
        }
    }
}
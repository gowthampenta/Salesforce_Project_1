public class DailyAccountUpdateJob7 implements Schedulable {
    public void execute(SchedulableContext sc) {
        System.debug('Im Executed Now');
    }
}
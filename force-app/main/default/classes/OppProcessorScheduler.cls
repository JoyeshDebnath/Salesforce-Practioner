public class OppProcessorScheduler implements Schedulable {
	
    public static void execute (SchedulableContext context){
        OppProcessor oppprocessor=new OppProcessor();
        Database.executeBatch(oppprocessor);
        
    }
}
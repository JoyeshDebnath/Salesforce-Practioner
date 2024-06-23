public class DailyOppProcessor implements Schedulable {
    public void execute(SchedulableContext context){
        List<Opportunity> oppList=[SELECT Id,Name,LeadSource 
                                   FROM Opportunity 
                                   WHERE LeadSource=null 
								   LIMIT 200];
        
        for(Opportunity opp: oppList){
            opp.LeadSource='web';
        }
        
        if(!oppList.isEmpty())
        	update oppList;
        
        
    }
}
public class DailyLeadProcessor implements Schedulable {
    public void execute (SchedulableContext context){
        List<Lead> leadList=[SELECT Id, LeadSource FROM Lead  
                             WHERE LeadSource=NULL 
                             LIMIT 200];
        for(Lead lead : leadList){
            lead.LeadSource='Dreamforce';
            
        }
        
        if(!leadList.isEmpty()){
            update leadList;
        }
    }
}
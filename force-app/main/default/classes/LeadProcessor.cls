public class LeadProcessor implements Database.Batchable<sObject>,Database.stateful {
    
    public integer numOfRecords=0;
    
    public Database.QueryLocator start(Database.BatchableContext bc ){
		return Database.getQueryLocator('SELECT Id,LeadSource FROM Lead');       
    }
    
    public void execute (Database.BatchableContext bc , List<Lead> leadList){
        for(Lead lead:leadList){
            lead.LeadSource='Dreamforce';
        }
        
        if(!leadList.isEmpty())
        		update leadList;
    }
    
    public void finish(Database.BatchableContext bc ){
        System.debug('Number Of Records :'+numOfRecords);
    }
    
}
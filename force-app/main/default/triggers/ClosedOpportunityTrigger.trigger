trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {
	
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ClosedOpportunityTriggerHandler.caseCreateHandler(Trigger.New,null);
        }
        if(Trigger.isUpdate){
            ClosedOpportunityTriggerHandler.caseCreateHandler(Trigger.New,Trigger.oldMap);
        }
    }
}
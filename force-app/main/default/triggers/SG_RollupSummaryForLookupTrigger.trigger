/*
    Whenever the opportunity is created , updated or deleted then Roll up the Opportunity Amount to 
    Accounts Annual Revenue
    
    class : OpportunityTriggerHandler
*/


trigger SG_RollupSummaryForLookupTrigger on Opportunity (after insert,after delete,after update) {

    if(trigger.isAfter){
        if(trigger.isInsert){
            OpportunityTriggerHandler.onAfterCreate(Trigger.New);
        }
        if(trigger.isUpdate){
            OpportunityTriggerHandler.onAfterUpdate(Trigger.New, Trigger.oldMap);
        }
        if(trigger.isDelete){
            OpportunityTriggerHandler.onAfterDelete(Trigger.Old);
        }
    }

}
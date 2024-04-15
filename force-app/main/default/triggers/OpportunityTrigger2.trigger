trigger OpportunityTrigger2 on Opportunity (after insert,after update,after delete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            OpportunityTrigger_1_Handler.onAfterInsert(Trigger.New);
        }
        else if(Trigger.isUpdate){
             OpportunityTrigger_1_Handler.onAfterUpdate(Trigger.New,Trigger.oldMap);
        }
        else if(Trigger.isDelete){
             OpportunityTrigger_1_Handler.onAfterDelete(Trigger.Old);
        }
    }
}
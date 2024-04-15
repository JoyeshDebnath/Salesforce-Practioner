trigger OpportunityTrigger3 on Opportunity (after insert,after update,after delete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            OpportunityTrigger3Handler.onAfterInsert(Trigger.New);
        }
        else if(Trigger.isUpdate){
            OpportunityTrigger3Handler.onAfterUpdate(Trigger.New, Trigger.oldMap);
        }
        else if(Trigger.isDelete){
            OpportunityTrigger3Handler.onAfterDelete(Trigger.Old);
        }
    }
}
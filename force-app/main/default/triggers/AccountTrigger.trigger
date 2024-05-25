trigger AccountTrigger on Account (before insert,after insert,before update,after update) {
    if(Trigger.isInsert ){
        if(Trigger.isBefore){
            AccountTriggerHandler.beforeInsert(Trigger.New);    
        }else if(Trigger.isAfter){
            AccountTriggerHandler.createRelatedOpportunities(Trigger.New);
        }
     }
    
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            AccountTriggerHandler.updatePhoneDescription(Trigger.New,Trigger.oldMap);      
        }
        else if(Trigger.isAfter){
            AccountTriggerHandler.updateRelatedOpportunityPhone(Trigger.New,Trigger.oldMap);
        }
    }
    
}
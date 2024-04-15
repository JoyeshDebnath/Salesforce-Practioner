trigger AccountTrigger2 on Account (before insert,before delete, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountTrigger_2_Handler.updateAccountDescriptionAndRating(Trigger.New);
        }
        else if(Trigger.isUpdate){
            AccountTrigger_2_Handler.updatePhoneDescription(Trigger.New,Trigger.oldMap);
        }
        else if(Trigger.isDelete){
            AccountTrigger_2_Handler.checkActiveStatus(Trigger.Old);
        }
    }
    
}
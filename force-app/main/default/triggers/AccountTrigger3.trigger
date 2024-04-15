trigger AccountTrigger3 on Account (before insert,before update,before delete,after insert , after update , after delete  ) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountTrigger_3_Handler.updateRating(Trigger.New);
        }else if(Trigger.isUpdate){
            AccountTrigger_3_Handler.updatePhoneDescription(Trigger.New, Trigger.oldMap);
        }
        else if(Trigger.isDelete){
            AccountTrigger_3_Handler.checkAccountStatus(Trigger.old);
        }
    }
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountTrigger_3_Handler.createRelatedOps(Trigger.New);
        }
    }
    
}
/**
 * Upon creation of contact record a welcome Email notification should be triggered to email id populated on contact 
 * record 
 */


trigger SG_EmailTrigger on Contact (after insert) {
        if(trigger.isAfter){
            if(Trigger.isInsert){
                    ContractTriggerHandler.sendEmailNotification(Trigger.New);
            }
        }
}
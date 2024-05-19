/**
 * Before insert : update account description 
 * before update : update account  description if account phone is updated 
 * before delete : show Error when active account deleted 
 * 
 * Trigger Controller Class : AccountTriggerController
 *   
 */



trigger SG_Before_InsertUpdateDelete on Account (before insert,before update,before delete) {

    if(trigger.isBefore){
            if(trigger.isInsert){
                    AccountTriggerController.updateAccountDescription(trigger.new);
            }
            else if(trigger.isUpdate){
                    AccountTriggerController.updatePhoneDescription(trigger.new, trigger.oldMap);
            }
            else if(trigger.isDelete){
                    AccountTriggerController.checkForActiveAccount(trigger.old);
            }
    }
}
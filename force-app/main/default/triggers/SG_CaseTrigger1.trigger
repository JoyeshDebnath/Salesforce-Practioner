/**
 * When a case is created on any account then populate the Case number on 
 * Latest Case Number field on Account . 
 * 
 * Class :  SG_CaseTrigger1Controller
 */

trigger SG_CaseTrigger1 on Case (after insert) {

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            SG_AccountTrigger5Controller.handleAfterInsert(Trigger.New);
        }
    }

}
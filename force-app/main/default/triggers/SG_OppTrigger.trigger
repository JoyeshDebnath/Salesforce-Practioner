/**
 * When an opportunity is created on any Account  
 * then copy the Latest Opprtunity Amount  in the 
 * "Latest Opportunity Amount " field 
 * 
 * Handler class :  SG_OppTriggerController | SG_OppTriggerControllerTest
 * 
 */

trigger SG_OppTrigger on Opportunity (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            SG_OppTriggerController.handleAfterOppInsert(Trigger.New);
        }
    }
}
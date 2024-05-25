/**
 * On Account 2 checkboxes avaialable : "New Opportunity" and "New Contact"
 * On account creating If the New Contact is checked then related Contact created 
 * If the New Opportunity is checked and :Active=Yes" then related Opportunity created 
 * 
 */

trigger SG_AccountTriggerFinal on Account (after insert) {
        if(Trigger.isAfter){
            if(Trigger.isInsert){
                    SG_AccountTriggerFinalController.createRelatedContactOrOpp(Trigger.New);
            }
        }
}
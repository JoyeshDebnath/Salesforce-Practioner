/**
 * Scenrio 1:
 * -------------------
 * On opportunity creation or updation based on Opportunity Stage 
 * set the description field as : 
 *  "Closed Lost" | "Closed Won " | "OPEN"
 * 
 * 
 */


trigger SG_OpportunityTriggerFinal on Opportunity (before insert,before update) {

    if(Trigger.isBefore){
            if(Trigger.isUpdate){
                SG_OpportunityTriggerFinalController.updateDescriptionBasedOnStage(Trigger.New, Trigger.oldMap);
            }
            if(Trigger.isInsert){
                SG_OpportunityTriggerFinalController.updateDescriptionBasedOnStage(Trigger.New,null);
            }
    }

}
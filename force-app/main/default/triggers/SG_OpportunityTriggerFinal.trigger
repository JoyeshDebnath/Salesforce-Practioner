/**
 * Scenrio 1:
 * -------------------
 * On opportunity creation or updation based on Opportunity Stage 
 * set the description field as : 
 *  "Closed Lost" | "Closed Won " | "OPEN"
 * 
 * 
 * Scenerio 2: 
 * -----------------
 * When an Opportunity Stage name is updated create a task record on Opportunity and Assign this to 
 * Opportunity Owner .
 * 
 */


trigger SG_OpportunityTriggerFinal on Opportunity (before insert,before update,after update,after insert ) {

    if(Trigger.isBefore){
            if(Trigger.isUpdate){
                SG_OpportunityTriggerFinalController.updateDescriptionBasedOnStage(Trigger.New, Trigger.oldMap);
            }
            if(Trigger.isInsert){
                SG_OpportunityTriggerFinalController.updateDescriptionBasedOnStage(Trigger.New,null);
            }
    }

    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            SG_OpportunityTriggerFinalController.createTaskRecord(Trigger.New,Trigger.oldMap);
        }
    }

}
/**After insert : 
 * 
 * On Opportunity Creation if the Amount is not null then add amount to Account Annual Revenue 
 * 
 * After Update : 
 * 
 * When Opportunity Amount Updates then Update the Account Annual Revenue too 
 * 
 * After Delete : 
 * 
 * When the Opportunity deleted then  update the Account Annual Revenue 
 * 
 * Controller Class :  ✍️ "OpportunityTriggerController"
 */



trigger SG_AfterInsertAfterDeleteAfterUpdate on Opportunity (after insert,after update,after delete) {

    if(trigger.isAfter){

        if(trigger.isInsert){
            OpportunityTriggerController.onAfterInsert(trigger.new);
        }
        else if(trigger.isUpdate){
            OpportunityTriggerController.onAfterUpdate(trigger.new,trigger.oldMap);
        }
        else if(trigger.isDelete){
            OpportunityTriggerController.onAfterDelete(trigger.old);
        }

    }
}
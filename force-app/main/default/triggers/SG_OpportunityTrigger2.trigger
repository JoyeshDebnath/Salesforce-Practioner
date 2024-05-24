/**
 * Upon Opportunity creatiion if the Amount is b/w 1000000 and 5000000 then populate 
 * 'Hot Opportunity' in description . 
 * 
 */

trigger SG_OpportunityTrigger2 on Opportunity (before insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            SG_OpportunityTrigger2Handler.onBeforeInsert(Trigger.New);
        }
    }

}
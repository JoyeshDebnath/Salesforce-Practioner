/**
 * When aCccount is created and CopyBillingToShippingAddress is checked 
 * Copy the Billing address to shipping address 
 * 
 */

trigger SG_AccountTrigger3 on Account (before  insert) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            SG_AccountTrigger3Handler.onAfterAccountInsert(Trigger.New);
        }
    }
}
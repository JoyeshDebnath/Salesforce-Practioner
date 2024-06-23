/**
 * Scenerio 1 :
 * --------------------
 * On Account 2 checkboxes avaialable : "New Opportunity" and "New Contact"
 * On account creating If the New Contact is checked then related Contact created 
 * If the New Opportunity is checked and :Active=Yes" then related Opportunity created 
 * 
 * Scenrio 2: 
 * ------------------------
 * When an account Phone field is updated then populate the below message in 
 * Description field . "Phone Field Is Updated ! : OLD Value:XXX  & New Value: XXX"
 * 
 * Scenerio : 3
 * --------------------
 * when an account is inserted or updated by clcking CopyBillingToSgippingAddress 
 * Copy the Billing to Shipping address 
 * 
 * Scenerio 4: 
 * ---------------
 * Upon account creation or updation if the Industry is MEDIA then rating Should be HOT . 
 *  
 * 
 * Scenerio 5: 
 * ----------------------
 * When account phone is updated then populate the account phone number in all related 
    Contacts Home Phone Field (USING Map Startegy )

Scenerio 6 : 

When account phone is updated then populate the account phone number in all related 
    Contacts Home Phone Field (Using Parent To Child SOQL Query  )

Scenerio 7: 
-------------------------------
When Account Billing address is updated then populate the billing address in related contacts Mailing adress . 
use both parent to child query and map strategy . 

Scenerio 8 :
-------------------------------

Whenn Account Active field is updated from Yes to No then update all related opportunity Stage as Closed Lost. 

Scenerio 9: 
------------
Prevent the deletion of accoutn record if active is Yes. 

Scenerio 10 : 
------------
Prevent Account Record From being Edited if the Account record was created 7 days back 

 */

trigger SG_AccountTriggerFinal on Account (after insert,before update,before insert,after update,before delete,after delete ){
        if(Trigger.isAfter){
        if(Trigger.isInsert){
                SG_AccountTriggerFinalController.createRelatedContactOrOpp(Trigger.New);
        }
            
            if(Trigger.isUpdate){
                SG_AccountTriggerFinalController.handleAccountPhoneUpdate(Trigger.New,Trigger.oldMap);
                // SG_AccountTriggerFinalController.handleCopyAccountBillingAddressToRelatedContactsMailingAddress_1(Trigger.New, Trigger.oldMap);
                SG_AccountTriggerFinalController.handleCopyAccountBillingAddressToRelatedContactsMailingAddress_2(Trigger.New, Trigger.oldMap);
                
                SG_AccountTriggerFinalController.updateRelatedOppStage(Trigger.New, Trigger.oldMap);
        }
        
        }
        if(Trigger.isBefore){
                if(Trigger.isUpdate){
                        SG_AccountTriggerFinalController.handleUpdatePhone(Trigger.New, Trigger.oldMap);

                        SG_AccountTriggerFinalController.copyBillingToShippingAddress(Trigger.New, Trigger.oldMap);

                        SG_AccountTriggerFinalController.updateAccountRating(Trigger.New, Trigger.oldMap);

                        SG_AccountTriggerFinalController.preventAccountEdit(Trigger.New, Trigger.oldMap);

                }
                if(Trigger.isInsert){
                        SG_AccountTriggerFinalController.copyBillingToShippingAddress(Trigger.New,null);
                        SG_AccountTriggerFinalController.updateAccountRating(Trigger.New, null);
                }
                if(Trigger.isDelete){
                        SG_AccountTriggerFinalController.preventDelete(Trigger.old);
                        
                }
        }
}
/**
 * When an account is created then create a related Contact Again 
 * 
 * When an account is created then create a related opportunity 
 * 
 * controller class :  SG_AccountTrigger4_Controller
 */

trigger SG_AccountTrigger4 on Account (after insert) {
        if(Trigger.isAfter){
            if(Trigger.isInsert){
                SG_AccountTrigger4_Controller.createRelatedContacts(Trigger.New);

                SG_AccountTrigger4_Controller.createRelatedOpps(Trigger.New);
            }
        }
}
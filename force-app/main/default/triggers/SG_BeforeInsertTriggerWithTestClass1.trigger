/**
 * On Account record creation if the industry field has value as 'Media' OR 'Energy' then populate 
 * Rating as 'Hot'
 * 
 * 
 */

trigger SG_BeforeInsertTriggerWithTestClass1 on Account (before insert) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            SG_AccountTriggerHandler.updateRating(Trigger.New);
        }
    }

}
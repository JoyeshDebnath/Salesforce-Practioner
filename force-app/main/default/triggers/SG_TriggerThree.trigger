/**
 * Case 1 : If Account Phone is updated then put the updated Message in the description
 *  
 * Case 2: If Account Phone is updated the populate that on all related opportunities 
 *  */

trigger SG_TriggerThree on Account (before update,after update) {

    //case 1: 
    if(trigger.isBefore && trigger.isUpdate){
        if(!trigger.new.isEmpty()){
            for(Account acc:trigger.new){
                if(trigger.oldMap.get(acc.Id).Phone != acc.Phone){
                    acc.Description='Phone Field Updated .';
                }
            }
        }
    }

    //case 2: 
    if(trigger.isAfter && trigger.isUpdate){
        List<Opportunity> oppToBeUpdated=new List<Opportunity>();
        Map<Id,Account> accMap=new Map<Id,Account>();
        if(!trigger.new.isEmpty()){
            for(Account acc : trigger.new){
                accMap.put(acc.Id,acc);
            }

            List<Opportunity> oppList=[SELECT Id,Name,Account_Phone__c,AccountId FROM Opportunity WHERE AccountId IN : accMap.keySet()];

            if(!oppList.isEmpty()){
                for(Opportunity opp : oppList){
                    opp.Account_Phone__c=accMap.get(opp.AccountId).Phone;
                    oppToBeUpdated.add(opp);
                }
            }            
        }
        if(!oppToBeUpdated.isEmpty()){
            update oppToBeUpdated;
        }
    }

}
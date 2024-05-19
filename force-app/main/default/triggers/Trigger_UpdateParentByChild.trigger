/*
    Whenevr a Contacts Description is updated then its Parent Account's Description is also  updated
*/


trigger Trigger_UpdateParentByChild on Contact (after update) {
    
    Set<Id> accIds = new Set<Id>();//set of account ids 

    if(trigger.isAfter && trigger.isUpdate){
        //null checks 
        if(!trigger.new.isEmpty()){
                for(Contact con:trigger.new){
                    if(con.AccountId!=null 
                    && 
                    (trigger.oldMap.get(con.Id).Description!=con.Description)){
                        // fetch the account 
                        accIds.add(con.AccountId);
                    }
                }
        }//getting all account ids whose contacts decription was updated .. 


    }

    if(!accIds.isEmpty()){
        Map<Id,Account> accMap=new Map<Id,Account>(
        [SELECT Id,Description FROM Account WHERE Id IN : accIds]
        );//id to account map 

    List<Account> accountListToBeUpdated=new List<Account>();

        if(!trigger.new.isEmpty()){
            for(Contact cont:trigger.new ){
                // get the account 
                Account acc=accMap.get(cont.AccountId);
                acc.Description = cont.Description;
                accountListToBeUpdated.add(acc);
            }
        }
            // bulk update the account
            if(!accountListToBeUpdated.isEmpty()){
                    update accountListToBeUpdated;
            }
    }
            

}
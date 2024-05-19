/** Trigger To Count Number Of Contacts Associated with an Account 
 * and Display the Contacts count on Accounts Custom Field  
 * 
 * Soln : 
 * Which object to create a trigger : Contact 
 * 
 * We can change the count contact after : -->> insert , delete , undelete and update 
 */

trigger RollUpSummaryTrigger on Contact (after update,after insert,after delete,after undelete) {
    
    Set<Id> accIds=new Set<Id>();//store the related account id 
    if(trigger.isAfter && (trigger.isInsert || trigger.isUndelete)){
        if(!trigger.new.isEmpty()){
            
            for(Contact con:trigger.new){
                    if(con.AccountId!=null){
                        accIds.add(con.AccountId);
                    }
            }
        }

    }
    //When  you update we need to check the new parent account and old parent account 
    if(trigger.isAfter && trigger.isUpdate){
        if(!trigger.new.isEmpty()){
            
            for(Contact con:trigger.new){
                    if(trigger.oldMap.get(con.Id).AccountId!=con.AccountId){
                            //check the old one 
                            if(trigger.oldMap.get(con.Id).AccountId!=null){
                                accIds.add(trigger.oldMap.get(con.Id).AccountId);
                            }
                            if(con.AccountId!=null){
                                accIds.add(con.AccountId);
                            }
                    }
            }
        }
    }


    //delete operation : we dont have new version of record in  delete so cant use the triggger.new method
    if(trigger.isAfter && trigger.isDelete){
        if(!trigger.old.isEmpty()){
            for(Contact con:trigger.old){
                if(con.AccountId!=null){
                    accIds.add(con.AccountId);
                }
            }
        }
    }

    //fetch the number of Contacts 
    if(!accIds.isEmpty()){
        //fetch th number of contacts for an account 
        List<Account> accList=[SELECT Id,Number_of_Contacts__c,(SELECT Id from Contacts) FROM Account WHERE Id IN : accIds ];
        List<Account> accntsToBeUpdated=new List<Account>();

        if(!accList.isEmpty()){
            for(Account acc:accList){
                acc.Number_of_Contacts__c=acc.Contacts.size();
                accntsToBeUpdated.add(acc);
            }
        }
        if(!accntsToBeUpdated.isEmpty()){
            update accntsToBeUpdated;
        }
    }
}
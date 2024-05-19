/* 
    Whenever Accounts Phone field is updated Then all its related Contacts Phone 
    field should also get updated with Parents Accounts Phone value 
*/

trigger UpdateChildByParent on Account (after insert) {
    
    Map<Id,Account> accMap=new Map<Id,Account>();

    if(trigger.isAfter && trigger.isUpdate){
            if(!trigger.new.isEmpty()){
                    for(Account acc : trigger.new){
                        //check if the Phone was updated ...
                        if(trigger.oldMap.get(acc.Id).Phone!=acc.Phone){
                                accMap.put(acc.Id,acc);
                        }
                    }
            }
    }//create a map of Id and account of the updated ones 

    List<Contact> conList=[SELECT Id,Phone,AccountId FROM 
                            Contact 
                            WHERE 
                            AccountId IN : accMap.keySet()
                            ];//fetch all related contacts 
    
    List<Contact> conListToBeUpdated=new List<Contact>();


    
        for(Contact con:conList){
            Account ParentAccnt=accMap.get(con.AccountId);
            con.Phone=ParentAccnt.Phone;
            conListToBeUpdated.add(con);
        }

    if(!conListToBeUpdated.isEmpty()){
        update conListToBeUpdated;
    }
}
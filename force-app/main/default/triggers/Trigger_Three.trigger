/**
 * When an account Phone field is Updated then all its Related Contacts Phone field should also get updated with Parents Account Phone .
 */

trigger Trigger_Three on Account (after Update) {
        //contex variable 
        Map<Id,Account> accountMap=new Map<Id,Account>();

        if(trigger.isUpdate && trigger.isAfter){
            if(!trigger.new.isEmpty()){
                //null check 
                for(Account acc:trigger.new){
                    if(trigger.oldMap.get(acc.Id).Phone!=acc.Phone){
                        accountMap.put(acc.Id,acc);
                    }
                }
            }
        }

    //fetch the contacts from the acccount details 
    List<Contact> contactList=[SELECT Id,AccountId,Phone FROM Contact WHERE AccountId IN:accountMap.keySet()];

    //check if there contact list is  null 
    List<Contact> updatedConList=new List<Contact>();
    if(!contactList.isEmpty()){
        for(Contact con:contactList){
            con.Phone=accountMap.get(con.AccountId).Phone;
            updatedConList.add(con);
        }
        
    }
    if(!updatedConList.isEmpty()){
        update updatedConList;
    }
}
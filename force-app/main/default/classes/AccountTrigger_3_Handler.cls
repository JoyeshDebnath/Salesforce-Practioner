/*
	handler for the Account Trigger 3
*/

public class AccountTrigger_3_Handler {

    public static void updateRating(List<Account> newList){
        for(Account acc:newList){
            if(acc.Industry==null){
                    acc.addError('Please Add Industry !');
            }
            else 
            {
                if(acc.Industry!=null && acc.Industry=='Media')
                   acc.Rating='Hot';
              
            
            }
            
        }
    }
    
    public static void updatePhoneDescription(List<Account> newList, Map<Id,Account> oldMap){
        for(Account acc:newList){
            if(oldMap!=null && acc.Phone!=oldMap.get(acc.Id).Phone)
            {
                if(acc.Phone==null)
                    acc.addError('Phonr number can tbe blank !');
                else
                   acc.Description='Phone is modified on the Account = '+acc.Phone;
        }
    }
    }
    
    public static void checkAccountStatus(List<Account> oldList){
        for(Account acc:oldList){
            if(acc.Active__c=='Yes'){
                acc.addError('Active Accounts cant be deleted !');
            }
            
        }
    }
    
    public static void createRelatedOps(List<Account> newList){
        List<Opportunity> oppToBeInserted=new List<Opportunity>();
        for(Account acc:newList){
           
             Opportunity opp=new Opportunity();
             opp.Name=acc.Name;
             opp.AccountId=acc.Id;
             opp.StageName='Prospecting';
            // opp.CloseDate=System.today();
             oppToBeInserted.add(opp);
            
        }
        try{
        if(!oppToBeInserted.isEmpty())
               insert oppToBeInserted;     
        }catch(DMLException e){
				 System.debug(e.getMessage());           
        }
       
    }
}
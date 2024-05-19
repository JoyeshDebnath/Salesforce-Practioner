public  class AccountTriggerController {
    
    public static void updateAccountDescription(List<Account> newList){
        
        for(Account acc:newList){
            if(acc.Industry!=null && acc.Industry=='Media')
                        acc.Rating='Hot';
            
            acc.Description=acc.Description+'  : Account is Created ..';
            
        }
        
    }

    public static void updatePhoneDescription(List<Account> newList,Map<Id,Account> oldMap){

        for(Account acc:newList){
            if(oldMap.get(acc.Id).Phone != acc.Phone){
                acc.Description = acc.Description+' Phone Field Is Updated..';
            }
        }
    }

    public static void checkForActiveAccount(List<Account> oldList){
        for(Account acc:oldList){
            if(acc.Active__c!=null && acc.Active__c=='Yes'){
                acc.addError('Active Account Cannot be Deleted ..');
            }
        }
    }
}
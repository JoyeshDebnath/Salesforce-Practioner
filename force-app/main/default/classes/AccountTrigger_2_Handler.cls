/*
this is for handling the logics of the acctount trigger 2 trigger 
*/

public class AccountTrigger_2_Handler {

    public static void updateAccountDescriptionAndRating(List<Account> newAccntList){
        for(Account acc:newAccntList){
            if(acc.Industry!=null && acc.Industry=='Media'){
                acc.Rating='Hot';
            }
            acc.Description='New Account is Created with name : '+acc.Name;
        }
    }
    
    public static void updatePhoneDescription(List<Account> newAccountList , Map<Id,Account> oldAccountMap){
        for(Account acc:newAccountList){
            if(oldAccountMap!=null && (acc.Phone!=oldAccountMap.get(acc.Id).Phone)){
                acc.Description='Phone Number of the Account :'+acc.Name+'   is Updated !';
            }
        }
    }
    
    public static void checkActiveStatus(List<Account> oldAccountList){
        for(Account acc : oldAccountList){
            if(acc.Active__c !=null && acc.Active__c=='Yes')
                    acc.addError('Active Account Cant be Deleted !');
        }
    }
}
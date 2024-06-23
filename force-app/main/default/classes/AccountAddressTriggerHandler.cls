public class AccountAddressTriggerHandler {

    public static void updateShippingPostalCodeInsert(List<Account> newAccList){
        
        
        
        for(Account acc:newAccList){
            if(acc.Match_Billing_Address__c){
                acc.ShippingPostalCode=acc.BillingPostalCode;
            }
            
        }
        
	}
    
    public static void updateShippingPostalCodeUpdate(List<Account> newAccList,Map<Id,Account> oldAccMap){
        for(Account acc:newAccList){
            if(acc.Match_Billing_Address__c){
                acc.ShippingPostalCode=acc.BillingPostalCode;
            }
            
        }
    }
    
}
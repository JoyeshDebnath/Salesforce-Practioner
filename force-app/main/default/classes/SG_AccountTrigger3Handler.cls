public  class SG_AccountTrigger3Handler {
    
    public static void onAfterAccountInsert(List<Account> newList){
        for(Account acc:newList){
            if(acc.Copy_Billing_to_Shipping__c){
                
                    acc.ShippingCity=acc.BillingCity;
                    acc.ShippingCountry=acc.BillingCountry;
                    acc.ShippingPostalCode=acc.BillingPostalCode;
                    acc.ShippingState=acc.BillingState;
                    acc.ShippingStreet=acc.BillingStreet;
                
            
            }
        }
    }
}
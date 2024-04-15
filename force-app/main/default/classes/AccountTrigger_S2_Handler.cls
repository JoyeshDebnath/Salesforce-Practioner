public class AccountTrigger_S2_Handler {

    public static void copyBillingtoShipping(List<Account> newList){
        
        for(Account acc:newList){
            if(acc.Copy_Billing_to_Shipping__c){
                acc.ShippingCity=acc.BillingCity;
                acc.Shippingcountry = acc.BillingCountry;
                acc.ShippingPostalCode=acc.BillingPostalCode;
                acc.ShippingState=acc.BillingState;
                acc.ShippingStreet=acc.BillingStreet;
            }
        }
    }
    
}
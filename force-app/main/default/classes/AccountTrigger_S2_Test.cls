@isTest
public class AccountTrigger_S2_Test {
   @isTest
        public static void testCopyBillingToShipping(){
         	   
            //create 
            Account acc=new Account();
            acc.Name='Test Account';
            acc.Copy_Billing_to_Shipping__c=true;
            acc.ShippingCity='Yokohoma';
            acc.ShippingCountry='Japan';
            acc.ShippingPostalCode='0000';
            acc.ShippingState='Tokyo';
            
        }
}
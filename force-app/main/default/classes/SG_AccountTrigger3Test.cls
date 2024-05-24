@isTest
public  class SG_AccountTrigger3Test {

        @isTest public static void testCopyBillingToShippingAddress(){
            Account acc=new Account();
            acc.Name='Test Account';
            acc.BillingCity='Tokyo';
            acc.BillingCountry='Japan';
            acc.BillingPostalCode='00000';
            acc.BillingState='test state';
            acc.BillingStreet='90 Tokyo Street';
            acc.Copy_Billing_to_Shipping__c=true;

            Test.startTest();
            insert acc;
            Test.stopTest();

            ID accId=acc.Id;
            List<Account> account=[SELECT Id,ShippingCity FROM Account WHERE Id=:accId];

            System.assertEquals('Tokyo', account[0].ShippingCity);
        }
}
@isTest
public class AccountTrigger_S2_HandlerTest {

   @isTest
        public static void testCopyBillingToShipping(){
         
              List<Account> accList=new List<Account>();
            //create 
          
            for(Integer i=1;i<=3;i++){
            
            Account acc=new Account();
            acc.Name='Test Account'+i;
            acc.Copy_Billing_to_Shipping__c=true;
            acc.BillingCity='Yokohoma';
            acc.BillingCountry='Japan';
            acc.BillingPostalCode='0000';
            acc.BillingState='Tokyo';
            acc.BillingStreet='12 Yokohoma Street';
            
            accList.add(acc);
         }
             //insert
             Test.startTest();
             insert accList;
            Test.stopTest();
           
            
            List<Account> recAcc=[SELECT Id,ShippingCountry FROM Account  WHERE Id =:accList[0].Id ];
            
            
            //Assert
            System.assertEquals('Japan',recAcc[0].ShippingCountry);
        }
}
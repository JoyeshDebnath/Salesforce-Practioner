@isTest
public  class SG_AccountTriggerHandler_Test {
        
    @isTest public static void testUpdateRating(){
            //create data 
            List<Account> accList=new List<Account>();
            for(Integer i=1;i<=5;i++){
                    Account acc=new Account();
                    acc.Name='Test Account '+i;
                    acc.Industry='Energy';
                    accList.add(acc);
            }

            Test.startTest();
                insert accList;
            Test.stopTest();

            List<Account> accsInserted=[SELECT Id,Rating FROM Account WHERE Id=:accList[0].Id ];
            System.assertEquals('Hot', accsInserted[0].Rating, 'Account rating must be hot ');
    }
}
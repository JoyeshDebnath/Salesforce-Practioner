@isTest
public class AccountTrigger_S3_HandlerTest {

    @isTest
    public static void testContactCreatin(){
        List<Account> accList=new List<Account>();
        for(Integer i=1;i<=3;i++){
            Account acc=new Account();
            acc.Name='Test Account Number '+ i;
            accList.add(acc);
        }
        
        Test.startTest();
        	insert accList;
        Test.stopTest();
        
        List<Contact> conList=[SELECT Id,AccountId FROM Contact WHERE AccountId =: accList[0].Id];
        System.assertEquals(accList[0].Id,conList[0].AccountId);
        
    }
}
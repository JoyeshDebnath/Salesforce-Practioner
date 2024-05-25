@isTest
public class SG_OppTriggerControllerTest {
    
    @isTest public static void testUpdateLatestAmount(){
        List<Account> accList=new List<Account>();
        List<Opportunity> oppList=new List<Opportunity>();

        for(Integer i=1;i<=5;i++){
            Account acc=new Account();
            acc.Name='Test Acc'+i;
            accList.add(acc);
        }

        insert accList;
        
        for(Account acc:accList){
            Opportunity opp=new Opportunity();
            opp.Name='Test opp'+acc.Name;
            opp.CloseDate=System.today();
            opp.StageName='Prospecting';
            opp.Amount=20000;
            opp.AccountId=acc.Id;
            oppList.add(opp);
        }
        Test.startTest();
        insert oppList;
        Test.stopTest();

        List<Account> updatedAccnt=[SELECT Id,Latest_Opportunity_Amount__c FROM Account WHERE Id=:accList[0].Id];

        System.assertEquals(20000, updatedAccnt[0].Latest_Opportunity_Amount__c);

        System.assertEquals(oppList[0].Amount, updatedAccnt[0].Latest_Opportunity_Amount__c);
    }
}
@isTest
public class CaseTrigger_S1_Handler_Test {

    @isTest
    public static void testLatestCaseNumChange(){
        
        Case c=new Case();
        c.Status='Working';
        c.Origin='Phone';
        c.AccountId='0015j00001ACIcyAAH';
        Test.startTest();
        	insert c;
        Test.stopTest();
        
        List<Account> acc=[SELECT Id,Latest_Case_Number__c FROM Account WHERE Id =:c.AccountId ];
        System.assertEquals(Decimal.valueOf(c.CaseNumber),acc[0].Latest_Case_Number__c);
    }
}
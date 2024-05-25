@isTest
public  class SG_AccountTrigger5Test {
    @isTest public static void testLatestCaseNumber(){
        Account acc=new Account(
            Name='Test Account'
        );

        insert acc;
        ID accId=acc.Id;
        
        Case c1=new Case(
            Origin='Web',
            Status='New',
            AccountId=accId
        );
        Case c2=new Case(
            Origin='Web',
            Status='New',
            AccountId=accId
        );

            Test.startTest();
            insert c1;
            insert c2;
            Test.stopTest();


            List<Account> accnt=[SELECT Id,Latest_Case__c FROM Account WHERE ID=:accId];

            System.assertEquals(c2.CaseNumber, accnt[0].Latest_Case__c);
    }
}
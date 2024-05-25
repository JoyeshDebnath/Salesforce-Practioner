@isTest
public  class SG_AccountTrigger4_Test {
    @isTest public static void testRelatedContactCreation(){
        Account account=new Account(
            Name='Test Account'
        );
        Test.startTest();
            insert account;
        Test.stopTest();

        ID accId=account.Id;
        List<Contact> conList=[SELECT Id,AccountId,Name FROM Contact WHERE Id=:accId];

        System.assert(conList!=null);
    }

    @isTest public static void testRelatedOppsCreation(){
        Account acc=new Account(
            Name='Test Account2'
        );

        Test.startTest();
            insert acc;
        Test.stopTest();

        ID accId=acc.Id;

        List<Opportunity> opps=[SELECT Id,AccountId FROM Opportunity WHERE AccountId=:accId];

        System.assert(opps!=null);
    }
}
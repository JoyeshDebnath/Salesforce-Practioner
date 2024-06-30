@isTest
public  class TestAccountDeletion {
    @isTest
    public static void testAccountDeletionPrevention(){
        //setup test data 
        Account acc=new Account(
            Name='test Account');
            insert acc;
        Opportunity opp=new Opportunity(
            Name='test Opportunity',
            StageName='Prospecting',
            CloseDate=System.today(),
            AccountId=acc.Id
        );

        insert opp;

        Test.startTest();
            Database.DeleteResult result=Database.delete(acc,false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.', result.getErrors()[0].getMessage());
    }
}
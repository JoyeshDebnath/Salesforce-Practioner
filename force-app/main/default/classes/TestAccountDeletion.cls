@isTest
public  class TestAccountDeletion {
    @isTest
    public static void testAccountDeletionPrevention(){
        Account[] accs=TestDataFactory.createAccountWithOpps(1, 1);

        Test.startTest();
            Database.DeleteResult result=Database.delete(accs[0],false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('Cannot delete account with related opportunities.', result.getErrors()[0].getMessage());
    }
}
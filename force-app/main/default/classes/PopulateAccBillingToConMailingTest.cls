@isTest 
public class PopulateAccBillingToConMailingTest {
	@isTest 
    private static void testUpdateBatch(){
        List<Account> accList=new List<Account>();
        List<Contact> conList=new List<Contact>();
        for(integer i=0;i<5;i++){
            accList.add(new Account(
                		Name='test acc'+i,
                       	BillingCity='Tokyo',
                       	BillingState='Tokyo',
                        BillingCountry='Japan',
                        BillingStreet='12/4 Ropongo Road',
                        BillingPostalCode='11111'
                       )
                     );
        }
        insert accList;
        
        for(Account acc:accList){
            Contact con=new Contact(
             	FirstName='test Contact',
                LastName=acc.Name,
                AccountId=acc.Id
            );
            conList.add(con);
        }
        insert conList;
        
        Test.startTest();
        PopulateAccBillingToConMailing batchJob=new PopulateAccBillingToConMailing();
        Id batchId=Database.executeBatch(batchJob,100);
        Test.stopTest();
        
        Integer countContactUpdate=[SELECT count() FROM Contact WHERE MailingCity='Tokyo'];
        
        System.assertEquals(5,countContactUpdate);
    }
}
@isTest 
public class UpdateContactQueuableTest {
    @testSetup
    static void setup(){
        List<Account> accList=new List<Account>();
        for(integer i=0;i<10;i++){
            Account acc=new Account();
            acc.Name='test Acc'+i;
            acc.Industry='Media';
            accList.add(acc);
        }
        insert accList;
        
        Contact contact=new Contact(
            FirstName='test',
            LastName='Contact'
            );
        insert contact;
    } 
		@isTest
    	private static void testCloneContact(){
        	
            Contact con=[SELECT Id,FirstName,LastName FROM  Contact 
                         WHERE FirstName='test' AND LastName='Contact'];
            String industryVal='Media';
            Test.startTest();
            	UpdateContactQueuable cloneContact=new UpdateContactQueuable(con,industryVal);
            	Id jobId=System.enqueueJob(cloneContact);
            Test.stopTest();
            
            
            System.assertEquals(10,[SELECT count() FROM Contact 
                                   WHERE AccountId IN (SELECT Id FROM Account WHERE Industry='Media')
                                   ]);
    	}
}
@isTest
public class AddPrimaryContactTest {
	@isTest
    public static void  testUpdateJob(){
        
        List<Account> accList=new List<Account>();
        for(integer i=1;i<=100;i++){
            Account acc=new Account();
            acc.Name='test Account '+i;
            if(i<=50){
                acc.BillingState='NY';
            }
            else{
                acc.BillingState='CA';
            }
            accList.add(acc);
        }
        
        insert accList;
         Test.startTest();
                    	Contact con=new Contact(
            			FirstName='Sample',
            			LastName='testContact'
            
        				);
        	AddPrimaryContact updateJob=new AddPrimaryContact(con,'CA');
			Id jobID=System.enqueueJob(updateJob);
         Test.stopTest();
        
        System.assertEquals(50,[SELECT count() FROM Contact WHERE FirstName='Sample']);
    }
}
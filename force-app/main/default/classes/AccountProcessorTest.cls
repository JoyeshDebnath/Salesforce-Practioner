@isTest 
public class AccountProcessorTest {
	@isTest 
    public static void testcountContacts(){
        List<Account> accList=new List<Account>();
        List<Id> accIds=new List<Id>();
        
        for(integer i=0;i<10;i++){
           accList.add(new Account (Name='Test Acc'+i)) ;   
        }
        insert accList;
        
        List<Contact> conList=new List<Contact>();
        
        for(Account acc: accList){
            accIds.add(acc.Id);
            Contact con=new Contact(
            		FirstName='test',
                	LastName=acc.Name,
                	AccountId=acc.Id
               );
        	conList.add(con);   	 
           }
        
        insert conList;
        
        Test.startTest();
        	AccountProcessor.countContacts(accIds);
        Test.stopTest();
        List<Account> accs=[SELECT Id,Number_of_Contacts__c  FROM Account ];
        System.assertEquals(1,accs[0].Number_of_Contacts__c);
        
    }
}
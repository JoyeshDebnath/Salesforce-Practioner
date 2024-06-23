@isTest
public class AccountCalculator_Test {
		@isTest
    	private static void countContactsTest(){
        	List<Account> accntList=new List<Account>();
            for(Integer i=0 ; i<160 ; i++){
                Account acc=new Account(Name='Test Account'+i);
                accntList.add(acc);
            }
            
            insert accntList;
            List<Contact> conList=new List<Contact>();
            List<Id> accIds=new List<Id>();
            for(Account acc:accntList){
                conList.add(new Contact(FirstName='Test',LastName=acc.Name,AccountId=acc.Id));
                accIds.add(acc.Id);
            }
            insert conList;
            
            Test.startTest();
            AccountCalculator.countContacts(accIds);
            Test.stopTest();
            
    	}
}
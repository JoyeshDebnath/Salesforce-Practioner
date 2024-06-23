public class AccountCalculator {
	@future
    public static void countContacts(List<Id> accntIds){
        List<Account> accList = [SELECT Id , 
                                	(SELECT Id FROM Contacts) 
                                		FROM Account 
                                		WHERE Id IN: accntIds];
        for(Account acc:accList){
            
            acc.ContactsNumber__c=acc.Contacts.size();
            
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
}
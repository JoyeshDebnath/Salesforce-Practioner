public class AccountProcessor {

    @future 
    public static void countContacts(List<Id> accIds){
    	List<Account> accList=[SELECT Id,Name,Number_of_Contacts__c,	 
                         (SELECT Id,FirstName, LastName FROM Contacts)
                         FROM Account WHERE Id IN : accIds
                        ];//query the accounts and related contacts associated . 
        for(Account acc:accList)
        {
              integer countOfRelatedContacts=acc.Contacts.size();//count the number of related contacts returned
              acc.Number_of_Contacts__c=countOfRelatedContacts;
        }//loop end s 
        
        if(!accList.isEmpty()){
            update accList;
            
        }
    }//future method 
}
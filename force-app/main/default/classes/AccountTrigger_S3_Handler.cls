public class AccountTrigger_S3_Handler {
 
    public static void createContact(List<Account> newList){
        //Set<Id> accntIds=new Set<Id>();
        List<Contact> contactsToBeInserted=new List<Contact>();
        
        for(Account acc : newList){
            Contact con=new Contact();
            con.LastName=acc.Name;
            con.AccountId=acc.Id;
            contactsToBeInserted.add(con);
        }
        
        if(!contactsToBeInserted.isEmpty())
                  insert contactsToBeInserted;
    }
}
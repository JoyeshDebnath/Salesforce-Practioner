public class AddPrimaryContact implements Queueable{

    private Contact contact;
    private String state;
    
    public AddPrimaryContact(Contact contact,String state){
        this.contact=contact;
        this.state=state;
    }
    
    public void execute (QueueableContext context){
        List<Contact> conList=new List<Contact>();
        List<Account> accList=[SELECT Id,Name,BillingState 
                              FROM Account
                              WHERE BillingState=:state
                              LIMIT 200
                              ];
        //create a copy of the contact passed .
        for(Account  acc:accList){
            Contact contactCopy=contact.clone(false,false,false,false);//create a copy  of the contact passed 
            contactCopy.AccountId=acc.Id;//relate the contact with the account .. 
            conList.add(contactCopy);
            
        }
        
        if(!conList.isEmpty()){
            insert conList;
        }
    }
}
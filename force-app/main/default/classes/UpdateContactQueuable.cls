public class UpdateContactQueuable implements Queueable{
    private Contact contact;
    private String industryValue;
    
    public UpdateContactQueuable(Contact contact,String industryValue){
        this.contact=contact;
        this.industryValue=industryValue;
    }
    
    public void execute (QueueableContext context){
    	
        List<Account> accList=[SELECT Id,Name FROM Account
                              WHERE Industry=:industryValue LIMIT 200];
        
        List<Contact> conList=new List<Contact>();
        
        for(Account acc:accList){
            Contact c=contact.clone(false,false,false,false);
            c.AccountId=acc.Id;
            conList.add(c);
        }
        
        if(!conList.isEmpty())
        	insert conList;
        
    }
}
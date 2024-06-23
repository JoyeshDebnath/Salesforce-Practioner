public class UpdateParentAccnt implements Queueable{
	
    private List<Account> accList;
    private Id parentAccntId;
    
    public UpdateParentAccnt(List<Account> accountList,Id parentAccountId){
        this.accList=accountList;
        this.parentAccntId=parentAccountId;
    }
    
    public void execute (QueueableContext context){
        
        for(Account acc: accList){
            acc.ParentId=parentAccntId;
        }
        
        update accList;
        
    }
}
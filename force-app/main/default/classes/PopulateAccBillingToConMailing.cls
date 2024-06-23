public class PopulateAccBillingToConMailing implements Database.Batchable<sObject>,Database.Stateful{
		
    public integer recordCount=0;
    
    public Database.QueryLocator start (Database.BatchableContext bc){
        return Database.getQueryLocator(
            'SELECT Id,BillingCity,BillingState,BillingCountry,BillingPostalCode,BillingStreet,'+
            '(SELECT Id,MailingStreet,MailingCity,MailingCountry,MailingPostalCode,MailingState FROM Contacts)'+
            ' FROM Account WHERE BillingCountry=\'Japan\' '
        );
    }
    
    public void execute (Database.BatchableContext bc , List<Account> accList){
        
        List<Contact> conList=new List<Contact>();
        
        for(Account acc:accList){
            
            for(Contact con:acc.Contacts){
                con.MailingCity=acc.BillingCity;
                con.MailingStreet=acc.BillingStreet;
                con.MailingCountry=acc.BillingCountry;
                con.MailingPostalCode=acc.BillingPostalCode;
                con.MailingState=acc.BillingState;
                conList.add(con);
                recordCount++;
            }
        }
        
        if(!conList.isEmpty()){
            update conList;
        }
    }
    
    public void finish (Database.BatchableContext bc ){
        System.debug('Record Count '+recordCount);
        
    }
}
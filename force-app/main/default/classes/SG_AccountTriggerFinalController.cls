public  class SG_AccountTriggerFinalController {
    public static void createRelatedContactOrOpp(List<Account> accList){
        //create reltaed contact 
        List<Contact> conList=new List<Contact>();
        List<Opportunity> oppList=new List<Opportunity>();
        
        for(Account acc:accList){
            if(acc.New_Contact__c){
                Contact con=new Contact();
                con.AccountId=acc.Id;
                con.FirstName=acc.Name;
                con.LastName=acc.Name;
                conList.add(con);
            }
        }
        if(!conList.isEmpty()){
            insert conList;
        }
        //create related opps
        for(Account acc:accList){
            if(acc.Active__c=='Yes' && acc.New_Opportunity__c){
                Opportunity opp=new Opportunity();
                opp.Name=acc.Name;
                opp.StageName='Prospecting';
                opp.CloseDate=System.today();
                opp.AccountId=acc.Id;
                oppList.add(opp);
            }
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }
}
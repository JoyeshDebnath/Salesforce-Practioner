public class AccountTriggerHandler {

    public static void beforeInsert(List<Account> newList){
                for(Account acc:newList){
                    if(acc.Industry != null && acc.Industry=='Media'){
                        acc.Rating='Hot';
                    }
                    else{
                        acc.Rating='Cold';
                    }
                }
    }
    
    
    public static void createRelatedOpportunities(List<Account> accountList){
        List<Opportunity> oppToBeInserted=new List<Opportunity>();
        for(Account acc:accountList){
            Opportunity opp=new Opportunity();
            opp.Name=acc.Name;
            opp.AccountId=acc.Id;
            opp.CloseDate=date.today();
            opp.StageName='Prospecting';
            opp.Project_Limit__c=2;
            oppToBeInserted.add(opp);
        }
        if(!oppToBeInserted.isEmpty()){
            insert oppToBeInserted;
        }
    }
    
    public static void updatePhoneDescription(List<Account> accountList,Map<Id,Account> oldMap){
        for(Account acc:accountList){
            if(oldMap!=null && acc.Phone!=oldMap.get(acc.Id).Phone){
                acc.Description='Phone is Modified on Account !';
            }
        }
    }
    
    public static void updateRelatedOpportunityPhone(List<Account> accountList,Map<Id,Account> oldMap){
        
        Map<Id,Account> accIdToAccountMap=new Map<Id,Account>();
        List<Opportunity> oppsToBeUpdated=new List<Opportunity>();
        
        for(Account acc : accountList){
            if(oldMap!=null && oldMap.get(acc.Id)!=null && acc.Phone!=oldMap.get(acc.Id).Phone){
        			accIdToAccountMap.put(acc.Id,acc);        	
            }
        }//filter the accounts whose phone were updated 
        
        for(Opportunity opp: [SELECT Id,AccountId,Account_Phone__c FROM Opportunity WHERE AccountId IN :accIdToAccountMap.keySet()]){
            Opportunity oppr=new Opportunity();
            if(accIdToAccountMap.containsKey(opp.AccountId)){
                oppr.Id=opp.Id;
                oppr.Account_Phone__c=accIdToAccountMap.get(opp.AccountId).Phone;
                oppsToBeUpdated.add(oppr);
            }
        }
        
        if(!oppsToBeUpdated.isEmpty())
                  update oppsToBeUpdated;
        
    }
}
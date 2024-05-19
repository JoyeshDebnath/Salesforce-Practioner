public class OpportunityTriggerController {
    
    public static void onAfterInsert(List<Opportunity> newList){
        Set<Id> accntIds=new Set<Id>();//account ids 
        List<Account> accountsToBeUpdated=new List<Account>();
        
        for(Opportunity opp:newList){
            if(opp.Amount!=null && opp.AccountId!=null){
                accntIds.add(opp.AccountId);
            }
        }
        
        accountsToBeUpdated=calculateAnnualRevenue(accntIds);
        
        if(!accountsToBeUpdated.isEmpty())
        {
            update accountsToBeUpdated;
        }
    }


    public static void onAfterUpdate(List<Opportunity> newList,Map<Id,Opportunity> oldMap){

        Set<Id> accntIds=new Set<Id>();//account ids 
        List<Account> accountsToBeUpdated=new List<Account>();
        
        for(Opportunity opp:newList){
            if(opp.Amount!=oldMap.get(opp.Id).Amount && opp.AccountId!=null){
                accntIds.add(opp.AccountId);
            }
        }
        
        accountsToBeUpdated=calculateAnnualRevenue(accntIds);
        
        if(!accountsToBeUpdated.isEmpty())
        {
            update accountsToBeUpdated;
        }

    }

    public static void onAfterDelete(List<Opportunity> oldList){

        Set<Id> accntIds=new Set<Id>();//account ids 
        List<Account> accountsToBeUpdated=new List<Account>();
        
        for(Opportunity opp:oldList){
            if(opp.Amount!=null && opp.AccountId!=null){
                accntIds.add(opp.AccountId);
            }
        }
        
        accountsToBeUpdated=calculateAnnualRevenue(accntIds);
        
        if(!accountsToBeUpdated.isEmpty())
        {
            update accountsToBeUpdated;
        }

    }

    public static List<Account> calculateAnnualRevenue(Set<Id> accountIds){
        List<Account> accountsToBeUpdated = new List<Account>();
        Map<Id,Decimal> accountIdToRevenueMap=new Map<Id,Decimal>();
        
        for(Opportunity opp:[SELECT Id,Amount,AccountId FROM Opportunity WHERE AccountId IN: accountIds]){
                Decimal total=0.0;
                if(accountIdToRevenueMap.containsKey(opp.AccountId)){
                    total=accountIdToRevenueMap.get(opp.AccountId);
                }
                if(opp.Amount!=null){
                    total+=opp.Amount;                
                }
                accountIdToRevenueMap.put(opp.AccountId, total);
        }//update and create ( AccountId --> Calculated Revenue ) Map
        
        if(!accountIdToRevenueMap.isEmpty()){
                for(Account acc:[SELECT Id,AnnualRevenue FROM Account WHERE Id IN : accountIds]){
                    acc.AnnualRevenue=accountIdToRevenueMap.get(acc.Id);
                    accountsToBeUpdated.add(acc);
                }
        }

        return accountsToBeUpdated;
    }
}
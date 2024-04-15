public class OpportunityTrigger3Handler {
    public static void onAfterInsert(List<Opportunity> newList){
        Set<Id> accIds=new Set<Id>();
        List<Account> accToBeUpdated=new List<Account>();
        for(Opportunity opp:newList){
            if(opp.AccountId!=null){
                accIds.add(opp.AccountId);
            }
        }
        
        accToBeUpdated=calcRevenue(accIds);
 
        if(!accToBeUpdated.isEmpty())
               update accToBeUpdated;
    }
    
    public static void onAfterUpdate(List<Opportunity> newList,Map<Id,Opportunity> oldMap){
        
        Set<Id> accIds=new Set<Id>();
        List<Account> accToBeUpdated=new List<Account>();
        
        for(Opportunity opp:newList){
            if(opp.AccountId!=null && (opp.Amount != oldMap.get(opp.Id).Amount)){
                accIds.add(opp.AccountId);
            }
        }
        
        accToBeUpdated=calcRevenue(accIds);
 
        if(!accToBeUpdated.isEmpty())
               update accToBeUpdated;
    }
    
    public static void onAfterDelete(List<Opportunity> oldList){
        Set<Id> accIds=new Set<Id>();
        List<Account> accToBeUpdated=new List<Account>();
        
        for(Opportunity opp:oldList){
            if(opp.AccountId!=null){
                accIds.add(opp.AccountId);
            }
        }
        
        accToBeUpdated=calcRevenue(accIds);
 
        if(!accToBeUpdated.isEmpty())
               update accToBeUpdated;
    }
    
    public static List<Account> calcRevenue(Set<Id> accIds){
        
        List<Account> accToBeUpdated=new List<Account>();
        Map<Id,Decimal> accIdToRev=new Map<Id,Decimal>();
        
        for(Opportunity opp:[SELECT Id,Amount,AccountId FROM Opportunity WHERE AccountId IN:accIds]){
            Decimal total=0;
            if(accIdToRev.containsKey(opp.AccountId)){
                total=accIdToRev.get(opp.AccountId);
            }
            
            if(opp.Amount!=null)
                 total+=opp.Amount;
            
            accIdToRev.put(opp.AccountId,total);
        }
        
        for(Id accId:accIdToRev.keySet()){
            Account acc=new Account();
            acc.id=accId;
            acc.AnnualRevenue=accIdToRev.get(accId);
            accToBeUpdated.add(acc);
        }
        return accToBeUpdated;
        
    }

}
/*
This is for handling the logics of the OpportunityTrigger2  
Find the Scenerio in OneNote 
*/

public class OpportunityTrigger_1_Handler {

    public static void onAfterInsert(List<Opportunity> newOpsList){
        Set<Id> accIds=new Set<Id>();
        List<Account> accToBeUpdated = new List<Account>();
        
        for(Opportunity opp:newOpsList){
            if(opp.AccountId!=null ){
                accIds.add(opp.AccountId);
            }
        }//filter 
        
        accToBeUpdated=calculateRevenue(accIds);
        
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
    }
    
    public static void onAfterUpdate(List<Opportunity> newList,Map<Id,Opportunity> oldMap){
        Set<Id> accIds=new Set<Id>();
        List<Account> accToBeUpdated = new List<Account>();
        
        for(Opportunity opp:newList){
            if(opp.AccountId!=null &&  opp.Amount!=oldMap.get(opp.Id).Amount){
                accIds.add(opp.AccountId);
            }
        }//filter 
        
        accToBeUpdated=calculateRevenue(accIds);
        
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
    }
    
    public static void onAfterDelete(List<Opportunity> oldList){
        Set<Id> accIds=new Set<Id>();
        List<Account> accToBeUpdated = new List<Account>();
        
        for(Opportunity opp : oldList){
            if(opp.AccountId!=null ){
                accIds.add(opp.AccountId);
            }
        }//filter 
        
        accToBeUpdated=calculateRevenue(accIds);
        
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
    }
    
    public static  List<Account> calculateRevenue(Set<Id> accIds){
        List<Account> accToBeUpdated=new List<Account>();
        Map<Id,Decimal> accIdToRevenueMap=new Map<Id,Decimal>();
        for(Opportunity opp: [SELECT Id, AccountId, Amount FROM Opportunity WHERE AccountId IN :accIds ]){
            
            Decimal total=0;
            if(opp.Amount!=null){
            if(accIdToRevenueMap.containsKey(opp.AccountId)){
                total=accIdToRevenueMap.get(opp.AccountId);
                 total=total+opp.Amount;
                 accIdToRevenueMap.put(opp.AccountId,total);
            }else{
                accIdToRevenueMap.put(opp.AccountId,0+opp.Amount);
            }
            
            }
            
        }//loop over opps
        
        for(Id accId:accIdToRevenueMap.keySet()){
            Account acc=new Account();
            acc.Id=accId;
            acc.AnnualRevenue=accIdToRevenueMap.get(accId);
            accToBeUpdated.add(acc);
        }
        
        return accToBeUpdated;
    }
}
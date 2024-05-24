public class OpportunityTriggerHandler {
    
    public static void onAfterCreate(List<Opportunity> newList){
            Set<Id> accountIds=new Set<Id>();
            List<Account> accountsToBeUpdated=new List<Account>();

            for(Opportunity opp:newList){
                if(opp.AccountId!=null){
                    accountIds.add(opp.AccountId);
                }
            }

            accountsToBeUpdated=calculateRevenue(accountIds);

            if(!accountsToBeUpdated.isEmpty()){
                update accountsToBeUpdated;
            }
    }

    public static void onAfterUpdate(List<Opportunity> newList,Map<Id,Opportunity> oldMap){
            Set<Id> accountIds=new Set<Id>();
            List<Account> accountsToBeUpdated=new List<Account>();

            for(Opportunity opp:newList){
                if(opp.AccountId!=null && opp.Amount!=oldMap.get(opp.Id).Amount){
                    accountIds.add(opp.AccountId);
                }
            }

            accountsToBeUpdated=calculateRevenue(accountIds);

            if(!accountsToBeUpdated.isEmpty()){
                update accountsToBeUpdated;
            }
    }

    public static void onAfterDelete(List<Opportunity> oldList){
            Set<Id> accountIds=new Set<Id>();
            List<Account> accountsToBeUpdated=new List<Account>();

            for(Opportunity opp:oldList){
                if(opp.AccountId!=null){
                    accountIds.add(opp.AccountId);
                }
            }

            accountsToBeUpdated=calculateRevenue(accountIds);

            if(!accountsToBeUpdated.isEmpty()){
                update accountsToBeUpdated;
            }
    }


    // calculate revenue 
    public static List<Account> calculateRevenue(Set<Id> accountIds){
        List<Account> accountsToBeUpdated=new List<Account>();
        Map<Id,Decimal> accIdToTotalAnnualRevenueMap=new Map<Id,Decimal>();

        for(Opportunity opp: [SELECT Id,AccountId,Amount FROM Opportunity WHERE AccountId IN : accountIds]){
            Decimal total=0.0;

            if(accIdToTotalAnnualRevenueMap.containsKey(opp.AccountId)){
                total=accIdToTotalAnnualRevenueMap.get(opp.AccountId);
            }

            if(opp.Amount!=null){
                total+=opp.Amount;
            }
            accIdToTotalAnnualRevenueMap.put(opp.AccountId,total);
        }

        // accountId: "939jnmnndxne22"-----> total:9000000
        if(!accIdToTotalAnnualRevenueMap.isEmpty()){
            for(Id accountId:accIdToTotalAnnualRevenueMap.keySet()){
                Decimal totalRevenue=accIdToTotalAnnualRevenueMap.get(accountId);
                Account acc=new Account();
                acc.Id=accountId;
                acc.AnnualRevenue=totalRevenue;
                accountsToBeUpdated.add(acc);

            }
        }

        return accountsToBeUpdated;


    }
}
public  class SG_OppTriggerController {
    
    public static void handleAfterOppInsert(List<Opportunity> oppList){
        List<Account> accountToBeUpdated=new List<Account>();

        for(Opportunity opp : oppList){
            if(opp.AccountId!=null && opp.Amount!=null){
                    Account acc=new Account();
                    acc.Id=opp.AccountId;
                    acc.Latest_Opportunity_Amount__c=opp.Amount;

                    accountToBeUpdated.add(acc);
            }
        }
        if(!accountToBeUpdated.isEmpty()){
            update accountToBeUpdated;
        }
    }
}
public  class SG_AccountTrigger5Controller {
    public static void handleAfterInsert(List<Case> caseList){
        // Set<Id> accountIds=new Set<Id>();
            Map<Id,Case> accountIdToCaseMap=new Map<Id,Case>();

        for(Case cse:caseList){
            if(cse.AccountId!=null){
                if(accountIdToCaseMap.containsKey(cse.AccountId)){
                    accountIdToCaseMap.remove(cse.AccountId);
                }
                accountIdToCaseMap.put(cse.AccountId,cse);
            }
        }

        List<Account> accountList=[SELECT Id,Latest_Case_Number__c FROM Account WHERE Id IN:accountIdToCaseMap.keySet()];
        
        List<Account> accntsToUpdate=new List<Account>();
        
        for(Account acc:accountList){
                String latestCaseNum=accountIdToCaseMap.get(acc.Id).CaseNumber;
                Account a=new Account();
                a.Id=acc.Id;
                a.Latest_Case__c=latestCaseNum;

                accntsToUpdate.add(a);
        }

        if(!accntsToUpdate.isEmpty())
                update accntsToUpdate;
    }
}
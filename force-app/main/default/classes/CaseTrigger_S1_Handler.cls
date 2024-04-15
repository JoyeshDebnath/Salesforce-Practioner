public class CaseTrigger_S1_Handler {
 
    public static void updateLatestCaseNumber(List<Case> newList){
       List<Account> accToBeUpdated=new List<Account>();  
        
        for(Case c:newList){
            if(c.AccountId!=null){
     				Account acc=new Account ();
                    acc.id=c.AccountId;
                    acc.Latest_Case_Number__c=Decimal.valueOf(c.CaseNumber);
                    accToBeUpdated.add(acc);
                }
        }//iterate 
        
        if(!accToBeUpdated.isEmpty()){
            update accToBeUpdated;
        }
    }
}
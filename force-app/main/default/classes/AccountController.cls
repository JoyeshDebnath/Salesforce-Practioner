public class AccountController {
    public static List<Account> insertAccounts(List<Account> accountsToInsert){
        insert accountsToInsert;
        return accountsToInsert;
    }
    
    public static Account insertSingleAccount(Account accountToInsert){
        insert accountToInsert;
        return accountToInsert;
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAllAccounts(){
        List<Account> accounts=[SELECT Name,Phone,Industry FROM Account LIMIT 10];
        return accounts;
    }
    
    public static void printAllAccounts(){
        List<Account> accounts = getAllAccounts();
        for(Account account:accounts){
            System.debug('The Account Name ='+ account.Name + '   The Account phone number = '+ account.Phone);
        }
     }
    
    public static Integer getAccountSize(){
        return getAllAccounts().size();
    }
    
    //bulkification challenge  Default code given to modify 👇

    public static void updateAvgCaseResolutionDays(Id accountId){
        Integer totalDays = 0;
        Integer totalCases = 0;
        //retrive all cases for this account 
        //get resolutiin days for each account (closed date - created date)
        for(Case caseObj : [SELECT Id,CreatedDate, ClosedDate 
                             FROM Case 
                             WHERE IsClosed=true 
                                 AND AccountId =:accountId]){
            
            totalCases++;
                                     
            totalDays+= caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());

        }//loop
		Decimal resolutionDays= (totalDays/totalCases);
        //update account obj 
        Account acc=new Account(Id=accountId ,Avg_Case_Resolution_Days__c=resolutionDays);
        update acc;
        
    }

   // bulfication challenge Soulntion code 👇
    public static void updateAvgCaseResolutionDays_modified(List<Id> accountIds){
        Map<Id,Integer> totalDaysMap = new Map<Id,Integer>();//store total days in map   : id-->total days 
        Map<Id,Integer> totalCasesMap = new Map<Id,Integer>();//store total cases in map : id-->> total cases 
        
        for(Case caseObj:[SELECT Id,CreatedDate,ClosedDate,AccountId
                          FROM  Case
                          Where isClosed=true
                          AND AccountId IN : accountIds
                         ]){
                        //if map does not have current account id then add it 
                             if(!totalCasesMap.containsKey(caseObj.AccountId)){
                                 totalDaysMap.put(caseObj.accountId,0);
                                 totalCasesMap.put(caseObj.AccountId,0);
                             }
                         //if the map contains the id then update it 
                             
                             
                             
                             
                             Integer totalCases = totalCasesMap.get(caseObj.AccountId);
                             totalCases++;
                             totalCasesMap.put(caseObj.AccountId,totalCases);

                             Integer totalDays=totalDaysMap.get(caseObj.AccountId);
                             totalDays+=caseObj.CreatedDate.date().daysBetween(caseObj.ClosedDate.date());
                             totalDaysMap.put(caseObj.accountId,totalDays);
                             
                            
                             
        }//loop 
        //create a list of account to update 
        List<Account> accountsToUpdate=new List<Account>();
        //iterate over the map 
        for(Id accountId : totalCasesMap.keySet() ){
            
            Decimal resolutionDays= totalDaysMap.get(accountId)/totalCasesMap.get(accountId);
            accountsToUpdate.add(new Account(Id=accountId,Avg_Case_Resolution_Days__c=resolutionDays));
        }//iterate over the maps 
        
       update accountsToUpdate;
        
    }     
}
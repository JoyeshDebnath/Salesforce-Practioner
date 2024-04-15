public with sharing class AccountController1 {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(){
            return [SELECT Id,Name,Type,Industry FROM Account LIMIT 5];
    }
}
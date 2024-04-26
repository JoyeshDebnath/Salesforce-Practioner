public with sharing class datatableController {
    @AuraEnabled(cacheable = true)
    public static List<Contact> fetchContactData(){
        List<Contact> conList=new List<Contact>();
        try{
                conList= [
                    SELECT Id,Name,Phone,Title,Email,
                    AccountId,Account.Name 
                    FROM Contact 
                    ORDER BY Name 
                    LIMIT 20];

                
        }catch(Exception err){
            System.debug(err.getMessage());
            throw new AuraHandledException(err.getMessage());
        }
            return  conList;
    }
}
public with sharing class DatatablePOC_Controller {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(){
        List<Contact> conList=new List<Contact>();
        try{
            conList=[SELECT Id,Name,Email,Title,Description,AccountId,Account.Name,Phone FROM Contact ];
        }catch(Exception error){
            throw new AuraHandledException(error.getMessage());
        }

        return conList;
    }
}
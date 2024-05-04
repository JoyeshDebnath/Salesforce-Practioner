public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactData(){
        List<Contact> contactList=new List<Contact>();
        try{
                contactList=[SELECT 
                Id,
                Name,
                Title,
                Phone,
                Email,
                Picture__c,
                Rank__c,
                AccountId,
                Account.Name 
                FROM Contact 
                WHERE AccountId != Null 
                LIMIt 10];
        }catch(Exception e){
            throw new AuraHandledException(e.getMessage());
        }
        
        return contactList;
    }
}
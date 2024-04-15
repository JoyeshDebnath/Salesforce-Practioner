/**
 * 
 * 
 */
public with sharing class CTPersonController {
   public static String getToken(String mobileNumber){
            Blob value = Blob.valueOf(mobileNumber);
            Blob hash = Crypto.generateDigest('MD5',value);
            //get the string value of the hash blop 
            return EncodingUtil.base64Encode(hash);
   }

   //get recent health chamges 
   public static List<Person__c> getRecentHealthChanges(){
            List<Person__c> allPersons = [SELECT Id,Name,Token__c,Status_Update_Date__c,Health_Status__c,
                                    Mobile__c FROM Person__c 
                                    ORDER BY Status_Update_Date__c DESC
                                    NULLS LAST
                                    LIMIT 100];
            return allPersons;
            
   }

   //search people 
   public static List<Person__c> searchPeople(String searchTerm){
      searchTerm+='%';
      List<Person__c> searchedPersons=[SELECT Id,Name,Token__c,Status_Update_Date__c,Health_Status__c,
                                    Mobile__c
                                    FROM Person__c 
                                    WHERE 
                                    Name LIKE :searchTerm OR Mobile__c LIKE :searchTerm OR Token__c LIKE :searchTerm 
                                    ORDER BY Status_Update_Date__c DESC 
                                    NULLS LAST ];
      return searchedPersons;
   }
   
   //get person by Id 
   public static Person__c getPersonById(Id personId){
      List<Person__c> searchedPerson=[SELECT Id,Name,Token__c,Status_Update_Date__c,Health_Status__c,
                                    Mobile__c FROM Person__c
                                    WHERE Id=:personId];
      if(searchedPerson!=null && searchedPerson.size()>0){
         return searchedPerson[0];
      }
      //else
      return null;
   }
}
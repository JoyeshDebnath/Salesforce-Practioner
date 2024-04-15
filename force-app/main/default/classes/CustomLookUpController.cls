public with sharing class CustomLookUpController {
    @AuraEnabled(cacheable=true)
    public static List<sObject> fetchLookUpData(String searchKey,String objectApiName){
        try {
            //create a generic SObject list to be returned ... 
            List<sObject> sObjectList=new List<sObject>();
            if(String.isBlank(searchKey)){
                return sObjectList;
                //if tyhe searcgh key is blank then return the generic sObject list ... 
            }else{
                //if the Search key is not blank then convert the search key as a wildcard parameter 
                String key='%'+searchKey+'%';//wildcarded parameter of search key 
                //prepare the Query To DB 
                String query='SELECT Id,Name FROM '+objectApiName+' WHERE Name LIKE:key ORDER BY Name LIMIT 5';
                //assign the tre result 
                sObjectList=Database.query(query,AccessLevel.USER_MODE);
                //only return those records for which the user has access . 
                return sObjectList;
            }

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}
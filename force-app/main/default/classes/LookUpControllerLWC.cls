public with sharing class LookUpControllerLWC {
    /*
        Custom search feature for lookup ;
        String objectname 
        String fieldApiname 
        Searchval
    */
    @AuraEnabled(cacheable=true)
    public static List<sObject> findRecords(String objectname,String searchVal,String fieldApiName){
        String searchKey='%'+searchVal+'%';
        String query='SELECT Id,'+fieldApiName+' FROM '+objectname+' WHERE '+fieldApiName+' LIKE:searchKey';

        List<sObject> sObjectList=Database.query(query);
        return sObjectList;
    } 
}
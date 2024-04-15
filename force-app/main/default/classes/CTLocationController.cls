public with sharing class CTLocationController {
  
    /**
     * get recent status changes : Query records all_fields * limit result to 100
     * sort by statusupdate date in descending order
     * return list 
     */
    public static List<Location__c> getRecentStatusChanges(){
        List<Location__c> locationRec = [SELECT 
                                    Id,Name,Address__c,Pincode__c,
                                    Red_Score__c,Status_Update_Date__c,Status__c  
                                    FROM Location__c 
                                    ORDER BY Status_Update_Date__c DESC 
                                    NULLS LAST 
                                    LIMIT 100];
        return locationRec;
    }

    /**
     * serach locations record based on search item and search for matches on basis
     *  of name , pincode amnd address
     */

     public static List<Location__c>  searchLocations(String searchTerm){
        searchTerm+='%';
        List<Location__c> locationRecs= [SELECT 
                                    Id,Name,Address__c,Pincode__c,
                                    Red_Score__c,Status_Update_Date__c,Status__c  
                                    FROM Location__c 
                                    WHERE Name LIKE :searchTerm OR Address__c LIKE :searchTerm
                                    OR Pincode__c LIKE :searchTerm
                                    ORDER BY Status_Update_Date__c DESC 
                                    NULLS LAST  
                                    ];
        return locationRecs;
     }

     public static Location__c getLocationById(String locationId){
        List<Location__c> locationRecs= [SELECT 
                                    Id,Name,Address__c,Pincode__c,
                                    Red_Score__c,Status_Update_Date__c,Status__c  
                                    FROM Location__c 
                                    WHERE Id=:locationId];
        if(locationRecs!=null && locationRecs.size()>0)
        return locationRecs[0];

        return null;
     }
}
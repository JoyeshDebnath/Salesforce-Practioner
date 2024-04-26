public with sharing class DynamicColumnDatatableCntrl {
    
    //function fetches dynamic column metadata information : Returns the list of DatatbleColumn_mdt records with specified Group name 
    @AuraEnabled(cacheable = true)
    public static List<DatatableColumn__mdt> getColumnsMetadata(String  groupName){
            return [
                SELECT 
                Field_Label__c,
                Field_Api__c,
                Data_Type__c,
                Initial_Width__c,
                Order__c,
                Additional_Props_JSON__c,
                Group__c
                FROM DatatableColumn__mdt
                WHERE Group__c=:groupName
                ORDER BY Order__c
            ];
    }

    //@description : fetch opportunities to show in datatable 
    @AuraEnabled(cacheable=true)
    public static DatatableConfigWrapper getOpportunitiesWithColumns(){
        //get the column config
        List<DatatableColumn__mdt> columns = getColumnsMetadata('Opportunity');
        List<String> fields=new List<String>();
        
    }

    //Description Wrapper for returning datat and column config for lighting datatable 
    public class DatatableConfigWrapper{
        @AuraEnabled
        public List<sObject> data {get; set;}
        @AuraEnabled
        public List<DatatableColumn__mdt> columnsInfo {get;set;} 
    }

    //check if the fields exists on an object 
    //param 1 : api name of the object 
    //param 2 : api name of the fields 
    //return : Returns True if the Fields Exists else False 
    private static Boolean isFieldValid(String objectApiName,String fieldApiName){
            Map<String,Schema.SObjectField> fieldMap = Schema.getGlobalDescribe()
                                                        .get(objectApiName)
                                                            .getDescribe()
                                                            .fields.getMap();
            return fieldMap.containsKey(fieldApiName);
    }
}
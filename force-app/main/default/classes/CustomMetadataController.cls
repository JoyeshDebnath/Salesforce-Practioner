public with sharing class CustomMetadataController {
    @AuraEnabled(cacheable = true)
    public static List<Dynamic_Table_Metadata__mdt> getStateRecords(){
        return Dynamic_Table_Metadata__mdt.getAll().values();
    }
}
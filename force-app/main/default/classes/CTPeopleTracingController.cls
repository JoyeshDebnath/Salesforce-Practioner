public with sharing class CTPeopleTracingController {

    public static List<People_Tracing__c> getTraces(String personId){
        return [SELECT Id,Name,Contact_Date__c,Person_1__c,Person_1__r.Health_Status__c,Person_1__r.Token__c,
                Person_2__c,Person_2__r.Health_Status__c,Person_2__r.Token__c 
                FROM People_Tracing__c
                WHERE Person_1__c=:personId
                OR Person_2__c=:personId
                ORDER BY Contact_Date__c DESC];
    }

    public static List<People_Tracing__c> checkDuplicates(List<People_Tracing__c> newPeopleTraces){

        //unique perosn ids 
        Set<Id> personIds=new Set<Id>();
        for(People_Tracing__c trace : newPeopleTraces){
            personIds.add(trace.Person_1__c);
            personIds.add(trace.Person_2__c);
        }
        //list of duplicate records to store duplicates 
        List<People_Tracing__c> duplicates=new List<People_Tracing__c>();
        Map<Id,Set<Id>> mapOfExisitingRecords=new Map<Id,Set<Id>>();
        //query the exiting records 
        List<People_Tracing__c> existingRecords = [SELECT Id,Person_1__c,Person_2__c FROM People_Tracing__c 
                                                WHERE Person_1__c IN : personIds OR Person_2__c IN : personIds];

        if(existingRecords!=null && existingRecords.size()>0){
            for(People_Tracing__c trace : existingRecords){
//buo;d map for peron 1 
                if(!mapOfExisitingRecords.containsKey(trace.Person_1__c)){
                        mapOfExisitingRecords.put(trace.Person_1__c, new Set<Id>());
                    }
                    mapOfExisitingRecords.get(trace.Person_1__c).add(trace.Person_2__c);
                        //build map for person 2 
                       if(!mapOfExisitingRecords.containsKey(trace.Person_2__c)){
                        mapOfExisitingRecords.put(trace.Person_2__c, new Set<Id>());
                    }
                    mapOfExisitingRecords.get(trace.Person_2__c).add(trace.Person_1__c);
            }
    }

    for(People_Tracing__c trace: newPeopleTraces){
        if((mapOfExisitingRecords.containsKey(trace.Person_1__c) && mapOfExisitingRecords.get(trace.Person_1__c).contains(trace.Person_2__c)) 
          || (mapOfExisitingRecords.containsKey(trace.Person_1__c) && mapOfExisitingRecords.get(trace.Person_1__c).contains(trace.Person_2__c))){
            duplicates.add(trace);
          }
    }
    return duplicates;
    }
}
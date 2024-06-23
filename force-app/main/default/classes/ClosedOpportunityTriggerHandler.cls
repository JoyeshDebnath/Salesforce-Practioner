public class ClosedOpportunityTriggerHandler {

    public static void caseCreateHandler(List<Opportunity> oppsList,Map<Id,Opportunity> oldMap){
        List<Task> taskList=new List<Task>();
        for(Opportunity opp:oppsList){
            if(opp.StageName=='Closed Won'){
                Task task=new Task(
                Subject='Follow Up Test Task',
                 WhatId=opp.Id
                );
                taskList.add(task);
            }
        }
        
        if(!taskList.isEmpty()){
            insert taskList;
        }
    }
    

}
public  class SG_OpportunityTriggerFinalController {
    
    public static void updateDescriptionBasedOnStage(List<Opportunity> newOppList,Map<Id,Opportunity> oldOppMap){
        for(Opportunity opp : newOppList){
            if(oldOppMap==null || 
            (oldOppMap.get(opp.Id).StageName!=opp.StageName)){

            if(opp.StageName=='Closed Won'){
                opp.Description='Opportunity is Closed Won';
            }
            else if(opp.StageName=='Closed Lost'){
                opp.Description='Opportunity is Closed Lost';
            }
            else {
                opp.Description='Opportunity is Open';
            }
        }

        

    }
}

    public static void createTaskRecord(List<Opportunity> newList,Map<Id,Opportunity> oldMap){

        List<Task> tasksToInsert=new List<Task>();
        for(Opportunity opp:newList){
            if(oldMap.get(opp.Id).StageName!=opp.StageName){
                    Task task=new Task();
                    task.OwnerId=opp.OwnerId;//Or : UserInfo.getUserId()
                    task.WhatId=opp.Id;//Related To 
                    task.status='Not Started';
                    task.Priority='Normal';
                    task.Subject='Demo Task';

                    tasksToInsert.add(task);
                
            }
        }

        if(!tasksToInsert.isEmpty()){
            insert tasksToInsert;
        }
    }
}
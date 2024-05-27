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
}
public  class SG_OpportunityTrigger2Handler {
    
    public static void onBeforeInsert(List<Opportunity> newList){
        for(Opportunity opp : newList){
                if(opp.Amount !=null && (opp.Amount>100000 && opp.Amount<500000)){
                    opp.Description='Hot Opportunity';
                }
        }
    }
}
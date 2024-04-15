public class OppTrigger_S1_Handler {

    public static void updateDescription(List<Opportunity> newList){
       
        
        for(Opportunity opp:newList){
            if(opp.Amount!=null && (opp.Amount>=100000 && opp.Amount<=500000))
                 opp.Description='Hot Opportunity';
        }
    }
}
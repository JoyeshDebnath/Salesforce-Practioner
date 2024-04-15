public class GovernorLimitChallenge_1 {

    public static void updateProfile(List<Id> oppIds){
        List<Opportunity> opps=[SELECT Id,Name,Amount,Profile__c FROM Opportunity WHERE Id IN: oppIds];
        for(Opportunity opp:opps){
            //get the record from id 
            //Opportunity opp=[SELECT Id,Name,Amount,Profile__c FROM Opportunity WHERE Id=: oppId ];
            if(opp.Amount==null)
            {
                opp.Profile__c='';
                
            }
            else if(opp.Amount<=10000)
                opp.Profile__c='Low';
            else if(opp.Amount>10000 && opp.Amount<=50000)
                opp.Profile__c='Medium';
            else
                opp.Profile__c='High';
          
            
        }
        update opps;
        
    }
}
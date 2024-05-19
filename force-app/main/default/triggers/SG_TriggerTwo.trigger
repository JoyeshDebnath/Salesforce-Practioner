/*
    If an Account Industry is Not null and having value as 'MEDIA' then populate Rating as 'HOT'--> Before Insert
    Create a Related Opportunity When account created -- After Insert
 */

trigger SG_TriggerTwo on Account (before insert,after insert) {
    // case 1: f an Account Industry is Not null and having value as 'MEDIA' then populate Rating as 'HOT
    if(trigger.isBefore && trigger.isInsert){
        if(!trigger.new.isEmpty()){
            for(Account acc:trigger.new){
                if(acc.Industry!=null && acc.Industry=='Media'){
                    acc.Rating='Hot';
                }
            }
        }
    }

    //case 2: Create a Related Opportunity When account created
    if(trigger.isAfter && trigger.isInsert){
        if(!trigger.new.isEmpty()){
            
            List<Opportunity> oppToBeInserted=new List<Opportunity>();

            for(Account acc:trigger.new){
                    Opportunity opp=new Opportunity();
                    opp.Name=acc.Name;
                    opp.AccountId=acc.Id;
                    opp.CloseDate=Date.today();
                    opp.StageName='Prospecting';

                    oppToBeInserted.add(opp);
                }
            if(!oppToBeInserted.isEmpty()){
                insert oppToBeInserted;
            }
        }
    }

}
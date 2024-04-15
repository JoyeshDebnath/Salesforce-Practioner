trigger LeadTrigger on Lead (before insert,before update) {
    //System.debug('Lead Trigger Called ! ');
    for(Lead leadRecord : Trigger.new){
        if(String.isBlank(leadRecord.LeadSource))
                   leadRecord.LeadSource='other';
        
        if(String.isBlank(leadRecord.Industry))
        {
            leadRecord.addError('The Industry field cant be Blank! ');
        }
    }
}